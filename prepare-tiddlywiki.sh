#!/bin/bash

# This script downloads and prepares TiddlyWiki 5 for inclusion in the app by compiling native modules

# 1. Download the TiddlyWiki5 branch "multi-wiki-support" into the folder ./nodejs-project
# 2. Build better-sqlite3 for ios-arm64 in ./TiddlyWiki/nodejs-project/node_modules/better-sqlite3

# Exit immediately if a command exits with a non-zero status
set -e

# Remove existing nodejs-project
rm -rf ./TiddlyWiki/nodejs-project

# Download TW5
REPO="Jermolene/TiddlyWiki5"
BRANCH="multi-wiki-support"
ZIP_URL="https://github.com/$REPO/archive/refs/heads/$BRANCH.zip"
TEMP_DIR=$(mktemp -d)
TEMP_ZIP="$TEMP_DIR/$BRANCH.zip"
curl -L $ZIP_URL -o $TEMP_ZIP
unzip -q $TEMP_ZIP -d ./TiddlyWiki
mv ./TiddlyWiki/TiddlyWiki5-multi-wiki-support ./TiddlyWiki/nodejs-project
rm -rf $TEMP_DIR
echo "TW5 downloaded"

# Remove existing node_modules
rm -rf ./TiddlyWiki/nodejs-project/node_modules

# Navigate to project directory
pushd "./TiddlyWiki/nodejs-project"

# Install the necessary packages
npm install better-sqlite3
npm install node-gyp-build

# Navigate to the better-sqlite3 directory
pushd "node_modules/better-sqlite3"

# Run the prebuild command
npx prebuild-for-nodejs-mobile ios-arm64

# Update package.json

node -e "
const fs = require('fs');
const path = 'package.json';

// Read the package.json file
fs.readFile(path, 'utf8', (err, data) => {
  if (err) {
    console.error('Error reading package.json:', err);
    return;
  }

  // Parse the existing package.json content
  const packageJson = JSON.parse(data);

  packageJson.name = 'better-sqlite3';
  packageJson.scripts.install = 'node-gyp-build';

  // Write the updated package.json back to file
  fs.writeFile(path, JSON.stringify(packageJson, null, 2), (err) => {
    if (err) {
      console.error('Error writing package.json:', err);
      return;
    }
    console.log('package.json updated successfully.');
  });
});
"

# Return to the project directory
popd

# Rebuild
npm rebuild
