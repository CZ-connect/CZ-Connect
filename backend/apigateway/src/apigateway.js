const express = require('express');
const morgan = require('morgan');

const PORT = process.env.PORT || '3000';

let app = express();

app.use(express.json());
app.use(morgan("combined")); // DEV

// Define routes
app.use('/applicantforms', require('./routes/ApplicantForms'));
app.use('/referrals', require('./routes/referrals'));

// Run the app
app.listen(PORT, () => {
    console.log(`Starting apigatewayservice on port ${ PORT } . . .`);
});

