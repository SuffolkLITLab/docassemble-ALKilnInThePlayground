#!/bin/bash

ALK_GLOBAL_DIR="/var/www/.npm-global"
if ! cd "$ALK_GLOBAL_DIR"; then
  echo "$(date) ALKiP ERROR: Unable to change to directory $ALK_GLOBAL_DIR."
  exit 2
fi

export NPM_CONFIG_PREFIX="/var/www/.npm-global"

PACKAGE="${1}"
VERSION="${2}"

# Install the package globally
if npm install -g "$PACKAGE@$VERSION" --loglevel=verbose; then
  echo "$(date) ALKiP INFO: On the 1st attempt, successfully installed $PACKAGE@$VERSION."
  exit 0
else
  echo "$(date) ALKiP INFO: 1st attempt failed to install $PACKAGE@$VERSION."
fi

source "$(dirname "$0")"/uninstall_global_npm_package.sh

# Install the package globally. Handle errors.
if npm install -g "$PACKAGE@$VERSION" --loglevel=verbose; then
  echo "$(date) ALKiP INFO: 2nd attempt successfully installed $PACKAGE@$VERSION."
  exit 0
else
  echo "$(date) ALKiP ERROR: After 2 attempts, failed to install $PACKAGE@$VERSION."
  exit 3
fi
