const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const home = require('./home');
const welcome = require('./welcome');
const background = require('./background');
const resources = require('./resources');
const error = require('./error');
const moreinfo = require('./moreinfo');
const results = require('./results');

router.use(bodyParser.urlencoded({extended: true}));
router.get('/', home.get);
router.get('/welcome', welcome.get);
router.get('/background', background.get);
router.get('/resources', resources.get);
router.get('/more-info', moreinfo.get);
router.get('/results', results.post); //used to be results.get

// trigger 500 error for testing

if(process.env.NODE_ENV === 'test') {
  const triggerError = () => (req, res, next) => {
  console.log('Testing 500')
  try {
    throw new Error('This function causes an error')
  } catch (error) {
    console.log("caught error");
    next(error)
  }
};
router.get("/error", triggerError());
}

// client error routes

router.use(error.client);
router.use(error.server);

router.use(error.get);

module.exports = router;