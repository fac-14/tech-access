var checkboxes = document.querySelectorAll('.govuk-checkboxes__input');

checkboxes.forEach(function (i) {
  i.addEventListener('click', clickFunc);
  if(sessionStorage.hasOwnProperty(i.value)){
    i.checked = true;
  }
})

function clickFunc() {
  if(this.checked){
    sessionStorage.setItem(this.value + '-background', this.value);
  } else {
    if(sessionStorage.hasOwnProperty(this.value)){
      sessionStorage.removeItem(this.value);
    }
  }
}