const express = require('express');
const path = require('path');
const app = express();

app.use(express.static(path.join(__dirname, 'public-flutter')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public-flutter/index.html'));
});

const port = process.env.PORT || 4000;

const server = app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});

module.exports = { app, server };
