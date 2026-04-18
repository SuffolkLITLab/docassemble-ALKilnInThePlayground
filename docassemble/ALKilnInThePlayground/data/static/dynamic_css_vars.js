// TODO: Run on resize
$(document).on("daPageLoad", function () {
  const nav_container = document.querySelector(
    ".danavbarcontainer:first-child .navbar"
  );
  const nav_height = $(nav_container).outerHeight(true);
  document.body.style.setProperty("--detected-nav-bar-height", nav_height + `px`);

  const h2_container = document.querySelector( "header.sticky_scroll:has(h2)" );
  const sticky_h2_height = $(h2_container).outerHeight(true) + 2;
  document.body.style.setProperty("--detected-h2-height", sticky_h2_height + `px`);

  const h3_container = document.querySelector( "header.sticky_scroll:has(h3)" );
  const sticky_h3_height = $(h3_container).outerHeight(true) + 2;
  document.body.style.setProperty("--detected-h3-height", sticky_h3_height + `px`);

  const h4_container = document.querySelector( "header.sticky_scroll:has(h4)" );
  if ( h4_container ) {
    const sticky_h4_height = $(h4_container).outerHeight(true) + 2;
    document.body.style.setProperty("--detected-h4-height", sticky_h4_height + `px`);
  }
})