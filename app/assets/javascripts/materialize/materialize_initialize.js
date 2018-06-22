(function($){
  $(function(){
    // TODO: Vanilla JSに修正する（本家の対応を待つ？）
    $('.sidenav').sidenav();
    $('.parallax').parallax();
  });
})(jQuery);

document.addEventListener('DOMContentLoaded', function() {
  var dropdownElems = document.querySelectorAll('.dropdown-trigger');
  var dropdownInstances = M.Dropdown.init(dropdownElems, { hover: false });
});

document.addEventListener('DOMContentLoaded', function() {
  var collapsibleElems = document.querySelectorAll('.collapsible');
  var collapsibleInstances = M.Collapsible.init(collapsibleElems, { accordion: true});
});

document.addEventListener('DOMContentLoaded', function() {
  var sidenavElems = document.querySelectorAll('.sidenav');
  var sidenavInstances = M.Sidenav.init(sidenavElems, {});
});
