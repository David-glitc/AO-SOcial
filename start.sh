#!/bin/bash

# Define project name
PROJECT_NAME="AO_Test_Social"

# Create project directory
mkdir $PROJECT_NAME
cd $PROJECT_NAME

# Initialize a new Node.js project
pnpm init

# Install dependencies
pnpm add esbuild express

# Create project structure
mkdir src dist
touch src/index.js src/index.html src/script.js server.js .gitignore

# Add basic content to index.js
echo "console.log('Hello, World!');" > src/index.js

# Add content to index.html
cat <<EOL > src/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Node.js App</title>
</head>
<body>
    <h1>Welcome to My Node.js App</h1>
    <button id="startButton">Start</button>
    <p id="response"></p>
    <script src="script.js"></script>
</body>
</html>
EOL

# Add content to script.js
cat <<EOL > src/script.js
document.getElementById('startButton').addEventListener('click', function() {
    fetch('/start')
        .then(response => response.text())
        .then(data => {
            console.log(data);
            document.getElementById('response').innerText = data;
        });
});
EOL

# Add content to server.js
cat <<EOL > server.js
const express = require('express');
const app = express();
const path = require('path');

app.use(express.static(path.join(__dirname, 'src')));

app.get('/start', (req, res) => {
    console.log('Button clicked');
    res.send('Button was clicked and this is the response!');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(\`Server is running on http://localhost:\${PORT}\`);
});
EOL

# Add build and start scripts to package.json
jq '.scripts.build = "esbuild src/index.js --bundle --outfile=dist/bundle.js"' package.json > tmp.json && mv tmp.json package.json
jq '.scripts.start = "node server.js"' package.json > tmp.json && mv tmp.json package.json

# Inform the user
echo "Project $PROJECT_NAME has been set up successfully!"
echo "Run 'pnpm run build' to build the project."
echo "Run 'pnpm start' to run the project."

# Display the final package.json
cat package.json
