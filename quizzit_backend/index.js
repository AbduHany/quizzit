const { server } = require("./src/app"); // Import the server from the app file

// Start the server and listen on port 3000
server.listen(3000, () => {
    console.log (`Server is running on port ${3000}.` );
    });