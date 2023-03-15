function validateAndSaveFormData(applicantForm) {
    try {
        var parsedForm = JSON.parse(applicantForm);

        // TODO: validate fields on parsedForm object

    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    validateAndSaveFormData
}