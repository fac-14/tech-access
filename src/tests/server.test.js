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

describe('Test error route', () => {
  test('It should respond with 500 to GET method', (done) => {
    supertest(app)
      .get('/error')
      .then((response) => {
        expect(response.statusCode).toBe(500);
        done();
    });
  });
});

describe('Test background route', () => {
  test('It should respond with 200 to GET method', (done) => {
    supertest(app)
      .get('/background')
      .then((response) => {
        expect(response.statusCode).toBe(200);
        done();
    });
  });
});

describe('Test resources route', () => {
  test('It should respond with 200 to GET method', (done) => {
    supertest(app)
      .get('/resources')
      .then((response) => {
        expect(response.statusCode).toBe(200);
        done();
    });
  });
});

describe('Test welcome route', () => {
  test('It should respond with 200 to GET method', (done) => {
    supertest(app)
      .get('/welcome')
      .then((response) => {
        expect(response.statusCode).toBe(200);
        done();
    });
  });
});

describe('Test more info route', () => {
  test('It should respond with 200 to GET method', (done) => {
    supertest(app)
      .get('/more-info')
      .then((response) => {
        expect(response.statusCode).toBe(200);
        done();
    });
  });
});

describe('Test results route', () => {
  test('It should respond with 200 to GET method', (done) => {
    supertest(app)
      .get('/results')
      .then((response) => {
        expect(response.statusCode).toBe(200);
        done();
    });
  });
});