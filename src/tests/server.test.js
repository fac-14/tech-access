const supertest = require('supertest');
const app = require('../app');

describe('Test home route', () => {
  test('It should respond with 200 to GET method', (done) => {
    supertest(app)
      .get('/')
      .then((response) => {
        expect(response.statusCode).toBe(200);
        done();
    });
  });
});

describe('Test error route', () => {
  test('It should respond with 404 to GET method', (done) => {
    supertest(app)
      .get('/eyjafjallajokull')
      .then((response) => {
        expect(response.statusCode).toBe(404);
        done();
    });
  });
});