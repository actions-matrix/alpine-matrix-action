#!/usr/bin/env bash

gh_set_output() {
    echo "Set output: $1=$2"
    echo "$1=$2" >> "$GITHUB_OUTPUT"
}

ALPINE_RELEASE_URL=${1:-${ALPINE_RELEASE_URL:-https://www.alpinelinux.org/releases.json}}
ALPINE_RELEASE_LATEST=${2:-${ALPINE_RELEASE_LATEST:-false}}
ALPINE_RELEASE_COUNT=${3:-${ALPINE_RELEASE_COUNT:-3}}

# Get the latest alpine release
ALPINE_RELEASE_BRANCHES=$(curl -s "${ALPINE_RELEASE_URL}" | jq -c -r ".release_branches[:${ALPINE_RELEASE_COUNT}]")

# Set the matrix
MATRIX_OS="[\"alpine\"]"
MATRIX_VERSION=$(echo "$ALPINE_RELEASE_BRANCHES" | jq -r '.[].rel_branch | sub("v";"")' | jq -c --raw-input --slurp 'sub("v";"") | split("\n") | map(select(. != ""))')

# If latest is enabled, add it to the matrix
if [[ "${ALPINE_RELEASE_LATEST}" == "true" ]]; then
    MATRIX_VERSION=$(echo "$MATRIX_VERSION" | jq -c '. + ["latest"]')
fi

# Set the outputs
gh_set_output "os" "${MATRIX_OS}"
gh_set_output "version" "${MATRIX_VERSION}"
gh_set_output "matrix" "{\"os\": ${MATRIX_OS}, \"version\": ${MATRIX_VERSION}}"
