$(document).on("turbolinks:load", function() {
  $(".post.card").on("click", "a.js-post-comment", (e) => {
    $(e.target).parents(".post.card").find("input.new_comment").focus();
    console.log("e.target", e.target);
    event.preventDefault();
  })
})