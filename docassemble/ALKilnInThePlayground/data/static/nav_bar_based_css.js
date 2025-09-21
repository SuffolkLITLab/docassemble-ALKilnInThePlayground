$(document).on("daPageLoad", function () {
  const nav_container = document.querySelector(
    ".danavbarcontainer:first-child .navbar"
  );
  const styles = window.getComputedStyle( nav_container );
  const height = $(nav_container).outerHeight(true);

  document.body.style.setProperty("--nav-bar-height", `${ height }px`);
})