$(document).on('turbolinks:load', () => {
  $('.message button.delete').on('click', event => {
    $(event.target).parents('.message').fadeOut();
  });
});
