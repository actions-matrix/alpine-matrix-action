#!/usr/bin/env bash

ALPINE_RELEASE_URL=${1}
ALPINE_RELEASE_COUNT=${2}

ALPINE_RELEASE_BRANCHES=$(curl -s "${ALPINE_RELEASE_URL}" | jq -c -r ".release_branches[:${ALPINE_RELEASE_COUNT}]")
MATRIX_VERSION=$(echo "$ALPINE_RELEASE_BRANCHES" | jq -r '.[].rel_branch | sub("v";"")' | jq -c --raw-input --slurp 'sub("v";"") | split("\n") | map(select(. != ""))')

echo "os=alpine" >> "$GITHUB_OUTPUT"
echo "version=${MATRIX_VERSION}" >> "$GITHUB_OUTPUT"
