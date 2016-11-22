#!/bin/sh

err() {
    >&2 echo "$@"
}


DEFAULT_CLONE_DEPTH=30
[ -z "${PLUGIN_DEPTH}" ] && PLUGIN_DEPTH="${DEFAULT_CLONE_DEPTH}"
[ -z "${PLUGIN_SPARSECHECKOUT}" ] && {
    err "sparseCheckout not set!"
    exit 1
}

if [ "{$CI}" != "drone" ] && [ "${DRONE}" != "true" ]; then
    err "Not a Drone CI environment"
    env
    exit 1
fi

set -xe

git config --global core.sparseCheckout true

if [ ! -d ".git" ]; then
    git init
    git remote add origin "${DRONE_REMOTE_URL}"
    echo "${PLUGIN_SPARSECHECKOUT}" > ".git/info/sparse-checkout"
    git pull origin "${DRONE_COMMIT_BRANCH}" --depth="${PLUGIN_DEPTH}"
else
    if [ -n "${DRONE_PULL_REQUEST}" ]; then
        DRONE_COMMIT_BRANCH="pull/${DRONE_PULL_REQUEST}/head:${DRONE_PULL_REQUEST}"
    fi
    echo "${PLUGIN_SPARSECHECKOUT}" > ".git/info/sparse-checkout"
    git fetch origin "${DRONE_COMMIT_BRANCH}" --depth="${PLUGIN_DEPTH}"
fi

git checkout -qf "${DRONE_COMMIT_SHA}"
cat "${PLUGIN_SPARSECHECKOUT}" >> ".git/info/sparse-checkout"
git checkout -qf "${DRONE_COMMIT_SHA}"

ls
