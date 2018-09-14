var checkboxes = document.querySelectorAll('.govuk-checkboxes__input');

for (var i=0; i < checkboxes.length; i++) {
  checkboxes[i].addEventListener('click', clickFunc);
}

function clickFunc() {
  localStorage.setItem(this.value, this.value);
}