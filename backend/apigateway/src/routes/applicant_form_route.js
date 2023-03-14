const express = require('express');
const router = express();
const CircuitBraker = require('opossum');

const applicantFormController = require('../controllers/applicant_form_controller');

const circuitBrakerOptions = {
    timeout: 5 * 1000,
    errorThresholdPercentage: 50,
    resetTimeout: 5 * 1000
};

const postBreaker = new CircuitBraker(
    applicantFormController.postApplication,
    circuitBrakerOptions);

function postApplicantForm(req, res, next) {
    postBreaker.fire(req.body)
        .then(results => {
            res.json(results)
        })
        .catch((err) => next(err));
}

router.route('/')
    .post(postApplicantForm);

module.exports = router;
