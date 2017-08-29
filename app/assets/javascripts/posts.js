$(document).on('turbolinks:load', function() {
  $('.post.card').on('click', 'a.js-post-comment', e => {
    $(e.target).parents('.post.card').find('input.js-new-comment').focus();
    console.log('e.target', e.target);
    event.preventDefault();
  });

  $('.js-enter-submit').on('click', e => {
    if ($(e.target).is(':checked')) {
      console.log('check');
      $(e.target).parents('form').find('.js-post-body').on('keydown', e => {
        if (e.key === 'Enter') {
          $(e.target).parents('form').submit();
          e.preventDefault();
        }
      });
    }
  });
});

window.PostsJs = {
  updateNewsfeed: postId => {
    $container = $('.js-posts');
    var latestPostId = $container.find('.js-post').first().data('post-id');
    $.get('/posts/insert_new?post_id=' + postId);
  }
};
