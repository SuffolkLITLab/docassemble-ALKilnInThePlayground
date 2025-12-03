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

## Discuss: This could be a last resort, but we want to avoid messing up other
##  globally installed packages
# rm -rf node_modules

npm cache clean --force

# Function to check package existence
check_package() {
  npm list -g --depth=0 | grep -q "$PACKAGE"
}

# Uninstall the package if it's installed globally
if check_package; then
  npm uninstall -g "$PACKAGE"

  # If failed to uninstall, try to remove manually with very powerful command
  # Be careful with this command
  if check_package; then
    echo "ALKiln WARNING: npm uninstall failed for $PACKAGE. Attempting rm -rf $GLOBAL_NODE_MODULES_PATH/$PACKAGE."
    rm -rf "$GLOBAL_NODE_MODULES_PATH/$PACKAGE"
  fi
fi
# Clean up unused dependencies
npm prune -g
