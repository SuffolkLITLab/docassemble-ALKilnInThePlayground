/**
 * When the user clicks an accordion header, go directly to the top of that
 * accordion section.
 * 
 * Rationale for using js instead of replacing the <button> with an anchor tag
 * (<a>) and linking to the top of the item: Semantically, a button is more
 * appropriate than an anchor tag. The fact that the click also navigates to the
 * top of the accordion item is, I hope, helpful to the user, but it's not the
 * main function of the accordion header. To clarify this, think about a screen
 * reader. Is it more important for the user of the screen reader to know that
 * clicking the header will link to the top of the accordion item (navigate) or
 * is it more important that the user know that clicking the header will show
 * the accordion content (reveal)? I believe it's the second one.
 * */
$(document).on(`daPageLoad`, function () {
  document.querySelectorAll(`.accordion-header`).forEach( header => {
    header.addEventListener(`click`, function() {
      const accordion_item = this.closest(`.accordion-item`);
      const item_top = accordion_item.getBoundingClientRect().top + window.scrollY;
      window.scrollTo({top: item_top - 200});  // Include top padding
    });
  });
});