const express = require('express');
const morgan = require('morgan');

const PORT = process.env.APIGTWY_PORT;

let app = express();

app.use(express.json());
app.use(morgan("combined")); // DEV

// Define routes
app.use('/applicantforms', require('./routes/applicant_form_route'));

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// Run the app
app.listen(PORT, () => {
    console.log(`Starting apigatewayservice on port ${ PORT } . . .`);
});

