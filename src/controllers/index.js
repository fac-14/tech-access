const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const home = require('./home')
const error = require('./error')

router.use(bodyParser.urlencoded({extended: true}));
router.get('/', home.get);

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