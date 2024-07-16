var express = require('express');
var router = express.Router(); // Create a new router object
const homeController = require('../controllers/homeController');

// Define the route for each endpoint and assign the corresponding handler
router.get('/status', homeController.status);
router.get('/version', homeController.version);
router.get('/quiz', homeController.quiz);

module.exports = router // Export the router for use in other files