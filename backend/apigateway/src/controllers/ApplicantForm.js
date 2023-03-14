function postApplication() {
    // Use RMQ
    return new Promise((resolve, reject) => {
        resolve({ Text: "Hello Word!" });
    });
}

module.exports = {
    postApplication
}