$(document).on(`daPageLoad`, function() { start_iframe_observer() });

async function start_iframe_observer() {
  if ( resize_obsv !== undefined ) { resize_obsv.disconnect() }
  // Trigger height change at page load then whenever visitor
  // changes viewport size, the DOM shifts, etc.
  var resize_obsv = new ResizeObserver(set_iframe);
  var outer_body = document.querySelector(`body`);
  resize_obsv.observe(outer_body);
};

$(document).on(`daPageLoad`, async function() {
  // Wait till a mysterious process from the server completes and has
  // removed the iframe content on every screen other than the first,
  // then re-populate the iframe.
  (async function( open ) {
    await set_iframe();
    XMLHttpRequest.prototype.open = function redo_iframe(m, u, a, us, p) {
      
      // Set the iframe content and size once
      this.addEventListener(
        'readystatechange', set_iframe, { once: true, capture: false, }
      );
      
      // Reset to original method to avoid calling `redo_iframe` on every checkin
      XMLHttpRequest.prototype.open = open;
      // Pass the args on to the original XMLHttpRequest.prototype.open
      open.call(this, m, u, a, us, p);
    };
  })(XMLHttpRequest.prototype.open);
});

async function set_iframe() {
  let iframe = document.getElementById(`alkiln_notifications`);
  if ( !iframe ) { return; }  // No iframe? Then no need for anything more
  
  let inner_doc = iframe.contentDocument || iframe.contentWindow.document;
  let content_node = inner_doc.getElementById(`broadsheet`);
  if ( !content_node ) { await refill_iframe(inner_doc); }
  
  resize_iframe(inner_doc);
}

async function refill_iframe( inner_doc ) {
  let content_data_holder = document.getElementById(`alkiln_broadsheet_content_data`);
  if ( !content_data_holder ) { return; }
  
  let decoded_content = decodeURIComponent(
    escape(
      atob(
        content_data_holder.dataset.broadsheet
      )
    )
  );
  inner_doc.querySelector(`body`).innerHTML = decoded_content;
}

function resize_iframe( inner_doc ) {
  let content_node = inner_doc.getElementById(`broadsheet`);
  if ( !content_node ) { return; }
  
  let iframe = document.getElementById(`alkiln_notifications`);
  // Adjust iframe height. WARNING: Avoid adjusting based on inner `body`
  // which changes when the iframe changes, causing a loop. Also, add extra
  // room for the inner `body`'s padding.
  iframe.height = `${ content_node.scrollHeight + 3 }px`;
}
