#!/bin/bash

# Define project name
PROJECT_NAME="AO_Social"

# Create project directory
mkdir $PROJECT_NAME
cd $PROJECT_NAME

# Initialize a new Node.js project
pnpm init

# Install dependencies
pnpm add esbuild

# Create project structure
mkdir src dist
touch src/index.js

# Add basic content to the index.js
echo "console.log('Hello, World!');" > src/index.js

# Add build and start scripts to package.json
jq '.scripts.build = "esbuild src/index.js --bundle --outfile=dist/bundle.js"' package.json > tmp.json && mv tmp.json package.json
jq '.scripts.start = "node dist/bundle.js"' package.json > tmp.json && mv tmp.json package.json

# Inform the user
echo "Project $PROJECT_NAME has been set up successfully!"
echo "Run 'pnpm run build' to build the project."
echo "Run 'pnpm start' to run the project."

# Display the final package.json
cat package.json
