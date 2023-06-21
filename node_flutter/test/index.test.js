const request = require('supertest');
const { app, server } = require('../app.js');

afterAll(done => {
    // Closes the server connection after tests are done
    server.close(done);
});

test('Root path works correctly', async () => {
    const res = await request(app)
        .get('/')
        .send();

    // Checks if the status code is 200
    expect(res.statusCode).toEqual(200);
});
