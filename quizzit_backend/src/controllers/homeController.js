const fs = require('fs'); // Import the file system module
const quiz_file = './src/assets/quiz.json' // Define the path to the quiz JSON file

module.exports = {
    // Handler for the /status route
    status: (req, res) => {
        res.status(200).send({ result: "Okay" });
    },

    // Handler for the /version route
    version: (req, res) => {

        try {
            const data = fs.readFileSync(quiz_file, 'utf8');
            const jdata = JSON.parse(data)
            console.log('File content:', jdata["version"]);
            res.status(200).send({ version: jdata["version"] });
        } catch (err) {
            console.error('Error reading file:', err);
        }
    },

    // Handler for the /quiz route
    quiz: (req, res) => {
       
        res.status(200).sendfile(quiz_file)

    }
}