const express = require('express');
const app = express(); // Create an instance of Express
const bodyParser = require("body-parser");
const server = require('http').createServer(app); // Create an HTTP server using the Express app
const PORT = process.env.PORT || 8080;
const cors = require("cors");

// CORS configuration
var corsOptions = { origin: "*" }; // Allow requests from any origin
app.use(cors(corsOptions));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Import the home routes
const homeRoutes = require('./routes/homeRoutes');
const path = require('path');

const v1 = '/api/v1' // Define the base API route
app.use(v1,homeRoutes)

// Serve static files from the 'public' directory
app.use(express.static('public'));

// Serve the index.html file for the root route
app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname, '/index.html'));
  });

module.exports = { PORT, server } // Export the PORT and server for use in other files
