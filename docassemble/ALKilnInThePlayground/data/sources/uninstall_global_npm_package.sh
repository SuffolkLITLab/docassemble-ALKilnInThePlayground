#!/bin/bash

ALK_GLOBAL_DIR="/var/www/.npm-global"
if ! cd "$ALK_GLOBAL_DIR"; then
  echo "$(date) ALKiP ERROR: Unable to change to directory $ALK_GLOBAL_DIR."
  exit 2
fi

export NPM_CONFIG_PREFIX="/var/www/.npm-global"

GLOBAL_NODE_MODULES_PATH="$ALK_GLOBAL_DIR/lib/node_modules"
PACKAGE="${1}"

## Discuss: This could be a last resort, but we want to avoid messing up other
##  globally installed packages
# rm -rf node_modules

npm cache clean --force --loglevel=verbose

# Function to check package existence
check_package() {
  npm list -g --depth=0 | grep -q "$PACKAGE"
}

# Uninstall the package if it's installed globally
if check_package; then
  npm uninstall -g "$PACKAGE" --loglevel=verbose

  # If failed to uninstall, try to remove manually with a powerful command
  # Be careful with this command
  if check_package; then
    echo "$(date) ALKiP NOTE: $PACKAGE still exists after uninstalling. Attempting rm -rf $GLOBAL_NODE_MODULES_PATH/$PACKAGE."
    rm -rf "$GLOBAL_NODE_MODULES_PATH/$PACKAGE"
  else
    echo "$(date) ALKiP INFO: successfully uninstalled $PACKAGE"
  fi
fi
