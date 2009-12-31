$(function () {
  $('.pagination a').live("click", function () {
    //$(".pagination").html('Page is loading...');
    //$(".loading").css('display', 'block').fadeOut(600);
    $.get(this.href, null, null, 'script');
    return false;
  });
});
