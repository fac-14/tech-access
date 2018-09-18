var bottomSection = document.getElementById('bottom-section');

setTimeout(function(){
  bottomSection.textContent = '';
  var form = document.createElement('FORM');
  form.setAttribute('action', '/welcome');
  form.classList.add('centered-content');
  bottomSection.appendChild(form);
  var btn = document.createElement('BUTTON');
  btn.classList.add('govuk-button', 'govuk-button--start', 'fade-in');
  btn.textContent = 'Get Started!';
  form.appendChild(btn)
}, 3000);