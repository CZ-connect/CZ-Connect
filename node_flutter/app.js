const express = require('express');
const path = require('path');
const app = express();
app.use(express.static(path.join(__dirname, 'public-flutter')));
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public-flutter/index.html'));
});

// Use the port provided by Azure App Service
const port = process.env.PORT || 4000;

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
