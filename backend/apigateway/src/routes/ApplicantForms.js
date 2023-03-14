const express = require('express');
const router = express();
const CircuitBraker = require('opossum');

const applicantFormsController = require('../controllers/ApplicantForm');

const circuitBrakerOptions = {
    timeout: 5 * 1000,
    errorThresholdPercentage: 50,
    resetTimeout: 5 * 1000
};

const postBreaker = new CircuitBraker(
    applicantFormsController.postApplication,
    circuitBrakerOptions);

function postApplicantForm(req, res, next) {
    postBreaker.fire(res, req, next)
        .then(results => {
            res.json(results)
        })
        .catch((err) => next(err));
}

router.route('/')
    .post(postApplicantForm);

module.exports = router;
