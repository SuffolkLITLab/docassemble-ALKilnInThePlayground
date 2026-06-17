#!/bin/bash

ALK_GLOBAL_DIR="/var/www/.npm-global"
if ! cd "$ALK_GLOBAL_DIR"; then
  echo "🤕 ALKP0045 ERROR [$(date)]: Unable to change to directory $ALK_GLOBAL_DIR."
  exit 2
fi

export NPM_CONFIG_PREFIX="/var/www/.npm-global"

PACKAGE="${1}"
VERSION="${2}"

# Install the package globally
if npm install -g "$PACKAGE@$VERSION" --loglevel=verbose; then
  echo "💡 ALKP0046 INFO [$(date)]: On the 1st attempt, successfully installed $PACKAGE@$VERSION."
  exit 0
else
  echo "🖊️ ALKP0047 NOTE [$(date)]: Failed to install $PACKAGE@$VERSION."
  exit 49
fi

# AVOID uninstalling ALKiln. Other authors may be using it.
