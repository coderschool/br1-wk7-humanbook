// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("turbolinks:load", (e) => {
  $(".file-input").on("change", (e) => {
    var file = e.target;
    $(e.target).parents(".file").find("span.file-label").html(file.files[0].name)
  })
})