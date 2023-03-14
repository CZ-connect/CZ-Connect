function validateAndSaveFormData(applicantForm) {
    try {
        var parsedForm = JSON.parse(applicantForm);

        // TODO: validate fields on parsedForm object

        return 'OK';
    } catch (error) {
        console.log(error);
        return 'ERR';
    }
}

module.exports = {
    validateAndSaveFormData
}