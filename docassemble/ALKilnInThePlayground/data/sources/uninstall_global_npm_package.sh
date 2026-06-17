#!/bin/bash

NPM_GLOBAL_PREFIX="/var/www"
ALK_GLOBAL_DIR="$NPM_GLOBAL_PREFIX/.npm-global"
if ! cd "$ALK_GLOBAL_DIR"; then
  echo "🤕 ALKP0039 ERROR [$(date)]: Unable to change to directory $ALK_GLOBAL_DIR."
  exit 2
fi

# `export` after verified to make the var accessible to the env. May be useful.
export NPM_GLOBAL_PREFIX="$NPM_GLOBAL_PREFIX"

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
exit_code=0
if check_package; then
  npm uninstall -g "$PACKAGE" --loglevel=verbose

  # If failed to uninstall, try to remove manually with a powerful command
  # Be careful with this command
  if check_package; then
    # Research: How to get the server into a state where we can test this path
    echo "🖊️ ALKP0040 NOTE [$(date)]: $PACKAGE still exists after uninstalling. Attempting rm -rf $GLOBAL_NODE_MODULES_PATH/$PACKAGE."
    rm -rf "$GLOBAL_NODE_MODULES_PATH/$PACKAGE" --verbose
    if check_package; then
      echo "🤕 ALKP0041 ERROR [$(date)]: $PACKAGE still exists after second attempt to uninstall."
      exit_code=41
    else
      echo "💡 ALKP0042 INFO [$(date)]: Successfully uninstalled $PACKAGE on the 2nd attempt."
    fi
  else
    echo "💡 ALKP0043 INFO [$(date)]: Successfully uninstalled $PACKAGE with the 1st attempt."
  fi
else
  echo "💡 ALKP0044 INFO [$(date)]: Already gone: ALKiln was not installed to begin with."
fi

# Clean up unused dependencies. Can't hurt.
npm prune --loglevel=verbose
echo "💡 ALKP0048 INFO [$(date)]: Pruned ALKiln's dependencies."
exit $exit_code
