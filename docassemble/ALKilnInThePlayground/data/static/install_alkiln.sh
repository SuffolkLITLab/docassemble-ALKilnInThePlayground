#!/bin/bash

ALK_GLOBAL_DIR="/var/www/.npm-global"
if ! cd "$ALK_GLOBAL_DIR"; then
  echo "ALKiln ERROR: Unable to change to directory $ALK_GLOBAL_DIR."
  exit 2
fi

export npm_config_cache="/var/www/.npm-global-cache"

GLOBAL_NODE_MODULES_PATH="$ALK_GLOBAL_DIR/lib/node_modules"
PACKAGE="${1}"
VERSION="${2}"

# Install the package globally
if npm install -g "$PACKAGE@$VERSION"; then
  echo "ALKiln INFO: Successfully installed $PACKAGE@$VERSION."
  exit 0
fi

source uninstall_alkiln.sh

# Install the package globally. Handle errors.
if npm install -g "$PACKAGE@$VERSION"; then
  echo "ALKiln INFO: Successfully installed $PACKAGE@$VERSION."
else
  echo "ALKiln ERROR: Failed to install $PACKAGE@$VERSION."
  exit 3
fi


# Original plan: Save pid from inside background task, access it outside.
# Problem: If we revoke the task before start, or subprocess itself errored that
# pid file won't be defined and thus the task will have been cancelled, but the
# pid will never terminate. That's why we need to come at it from the other end.

# # Detect if the cancelling finished it or if it finished installing first and
# # return that in the background response

