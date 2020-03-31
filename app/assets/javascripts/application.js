//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap
//= require select2.min
//= require i18n/ru
//= require jquery.toast.min
//= require_tree .

function toggleButtonState(buttonId, attributes) {
  $(buttonId).attr(attributes);
}

function initializeSelectInputs() {
  $('select').select2({
    theme: 'bootstrap4',
    language: 'ru',
    containerCSS: { 'display': 'block' }
  });
}

$(document).ready(function () {
  initializeSelectInputs();
});
