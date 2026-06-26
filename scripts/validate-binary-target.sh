#!/usr/bin/env bash
#
# validate-binary-target.sh - verify the binary XCFramework declared in Package.swift.
#
# This script reads the binary target's URL and checksum from the evaluated
# SwiftPM manifest, so interpolated URLs such as "...\(version).xcframework.zip"
# are resolved before validation.

set -euo pipefail

echo "==> Reading evaluated manifest"
DUMP="$(swift package dump-package)"

URL="$(printf '%s' "$DUMP" | jq -r '.targets[] | select(.type=="binary") | .url' | head -n1)"
CHECKSUM="$(printf '%s' "$DUMP" | jq -r '.targets[] | select(.type=="binary") | .checksum' | head -n1)"

echo "    url:      ${URL:-<none>}"
echo "    checksum: ${CHECKSUM:-<none>}"

if [[ -z "${URL}" || "${URL}" == "null" ]]; then
  echo "::error::No binary target URL found in Package.swift."
  exit 1
fi

if [[ -z "${CHECKSUM}" || "${CHECKSUM}" == "null" || "${CHECKSUM}" == REPLACE_* ]]; then
  echo "::error::Checksum is missing or still a placeholder."
  echo "         Generate it with: swift package compute-checksum <artifact>.xcframework.zip"
  exit 1
fi

if [[ ! "${CHECKSUM}" =~ ^[0-9a-f]{64}$ ]]; then
  echo "::error::Checksum must be a 64-character lowercase SHA-256 digest."
  exit 1
fi

if [[ ! "${URL}" =~ ^https:// ]]; then
  echo "::error::Binary target URL must use HTTPS."
  exit 1
fi

echo "==> Checking URL reachability"
HTTP_CODE="$(curl -sSL -o /dev/null -w '%{http_code}' --retry 3 --retry-delay 5 --max-time 180 "${URL}" || echo "000")"
if [[ "${HTTP_CODE}" != "200" ]]; then
  echo "::error::Binary target URL returned HTTP ${HTTP_CODE}: ${URL}"
  exit 1
fi

TMP="$(mktemp -d)"
trap 'rm -rf "${TMP}"' EXIT
ARTIFACT="${TMP}/artifact.xcframework.zip"

echo "==> Downloading artifact"
curl -sSL --retry 3 --retry-delay 5 --max-time 600 -o "${ARTIFACT}" "${URL}"

echo "==> Computing SwiftPM checksum"
ACTUAL="$(swift package compute-checksum "${ARTIFACT}")"
echo "    declared: ${CHECKSUM}"
echo "    actual:   ${ACTUAL}"

if [[ "${ACTUAL}" != "${CHECKSUM}" ]]; then
  echo "::error::Checksum mismatch. Update 'let checksum' in Package.swift to: ${ACTUAL}"
  exit 1
fi

if ! unzip -l "${ARTIFACT}" | grep -Eq '\.xcframework(/|$)'; then
  echo "::error::Artifact does not contain an .xcframework directory."
  exit 1
fi

echo "==> Binary target validated successfully"
