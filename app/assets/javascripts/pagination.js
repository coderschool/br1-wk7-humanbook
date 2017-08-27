$(document).on('turbolinks:load', setupInfiniteScroll);

function setupInfiniteScrollDummy(event) {
  $(window).on('scroll', function(e) {
    console.log('scrolling, currently at position', $(window).scrollTop());
  });
}

function setupInfiniteScroll(e) {
  if ($('.pagination').length == 0) {
    return;
  }

  const THRESHOLD = 300;
  const $paginationElem = $('.pagination');
  const $window = $(window);
  const $document = $(document);
  const paginationUrl = $paginationElem.attr('data-pagination-endpoint');
  const pagesAmount = $paginationElem.attr('data-pagination-pages');
  let currentPage = 1;
  let baseEndpoint;

  /* validate if the pagination URL has query params */
  if (paginationUrl.indexOf('?') != -1) {
    baseEndpoint = paginationUrl + '&page=';
  } else {
    baseEndpoint = paginationUrl + '?page=';
  }

  /* initialize pagination */
  $paginationElem.hide();
  let isPaginating = false;

  /* listen to scrolling */
  $window.on(
    'scroll',
    debounce(function() {
      console.log('scrolling', 'current page: ', currentPage, 'total pages: ', pagesAmount);
      if (!isPaginating && currentPage < pagesAmount && $window.scrollTop() > $document.height() - $window.height() - THRESHOLD) {
        isPaginating = true;
        currentPage++;
        $paginationElem.show();
        $.ajax({
          url: baseEndpoint + currentPage
        }).done(function(result) {
          $('.js-posts').append(result);
          isPaginating = false;
        });
      }
      if (currentPage >= pagesAmount) {
        $paginationElem.hide();
      }
    }, 100)
  );
}

// Returns a function, that, as long as it continues to be invoked, will not
// be triggered. The function will be called after it stops being called for
// N milliseconds. If `immediate` is passed, trigger the function on the
// leading edge, instead of the trailing.
function debounce(func, wait, immediate) {
  var timeout;
  return function() {
    var context = this,
      args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
}
