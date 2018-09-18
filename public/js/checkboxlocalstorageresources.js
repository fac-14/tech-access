var checkboxes = document.querySelectorAll('.govuk-checkboxes__input');

checkboxes.forEach(function (i) {
  i.addEventListener('click', clickFunc);
  if(sessionStorage.hasOwnProperty(i.value + '-resource')){
    i.checked = true;
  }
})

function clickFunc() {
  if(this.checked){
    sessionStorage.setItem(this.value + '-resource', this.value);
  } else {
    if(sessionStorage.hasOwnProperty(this.value + '-resource')){
      sessionStorage.removeItem(this.value + '-resource');
    }
  }
}