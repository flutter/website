//= require vendor/jquery-3.3.1
//= require popper
//= require bootstrap
//= require archive.js

$(function () {
  // // Sidenav
  // $('#sidenav i').on('click', function (e) {
  //   e.stopPropagation();
  //   $(this).parent('li').toggleClass('active');
  // });

  adjustToc();
  initFixedColumns();
})

// TODO(chalin): Copied (& tweaked) from site-www, consider moving into site-shared
function adjustToc() {
  // Adjustments to the jekyll-toc TOC.

  var tocId = '#site-toc__side';
  var tocWrapper = $(tocId);
  $(tocWrapper).find('.site-toc--button__page-top').click(function() {
    $('html, body').animate({ scrollTop: 0 }, 'fast');
  })

  // TODO: consider doing most of the HTML TOC manipulation statically (maybe requiring a jekyll-toc adaptor plugin)
  // Bootstrap 4's ScrollSpy works only for .nav or .list-group,
  // with items and link classes set too. Add the classes.
  var toc = $(tocWrapper).find('ul.section-nav');
  $(toc).addClass('nav');

  var ul = $(toc).find('ul');
  $(ul).addClass('nav');
  var li = $(toc).find('.toc-entry');
  $(li).addClass('nav-item');
  $(li).find('a').addClass('nav-link');

  $('body').scrollspy({ offset: 100, target: tocId });
}

function initFixedColumns() {
  var fixedColumnsSelector = '[data-fixed-column]';
  var footerSelector = 'footer.site-footer';
  var headerHeight = 66;

  function adjustFixedColumns() {
    var footerOffset = $(footerSelector).offset().top;
    var footerPosition = footerOffset - $(window).scrollTop();
    var footerVisibleOffset = $(window).height() - footerPosition;
    if (footerVisibleOffset > 0) {
      var fixedColumnsMaxHeight = $(window).height() - headerHeight - footerVisibleOffset;
      $(fixedColumnsSelector).css('max-height', fixedColumnsMaxHeight);
    } else {
      $(fixedColumnsSelector).css('max-height', '');
    }
  }

  // listen for scroll and execute once
  $(window).scroll(adjustFixedColumns);
  adjustFixedColumns();
}
