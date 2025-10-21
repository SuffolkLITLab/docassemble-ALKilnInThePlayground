$(document).on('daPageLoad', function () {

  try {
    const copy_nodes = document.querySelectorAll('.alkiln_copy');

    for ( let copy_node of copy_nodes ) {
      add_copy_event_listeners( copy_node );
    }

  } catch ( error ) {
    console.warn( 'Error in ALKiln copy button instantiation');
    console.warn( error );
  }
});

async function add_copy_event_listeners( node ) {

  const visible = node.querySelector(`.visible_text`);
  const to_copy_from = node.querySelector(`.to_copy`);
  const button = node.querySelector(`.copy_button`);
  
  const status_default = node.querySelector(`.copy_default`);
  const status_copied = node.querySelector(`.copy_done`);
  const status_cancelled_copy = node.querySelector(`.copy_cancelled`);
  const statuses = [ status_default, status_copied, status_cancelled_copy ];
  $(status_copied).hide()
  $(status_cancelled_copy).hide()

  button.addEventListener( `click`, async function ( event ) {
    try {

      let visible_text = visible.textContent;
      // Must be a textarea
      to_copy_from.innerHTML = visible_text;
      
      $(to_copy_from).focus();
      $(to_copy_from).select();
      let text = to_copy_from.textContent;
      await navigator.clipboard.writeText(text);

      show_status({ statuses, to_show: status_copied });
      $(to_copy_from).blur();
      show_status({ statuses, to_show: status_copied });

    } catch ( error ) {
      $(to_copy_from).blur();
      show_status({ statuses, to_show: status_cancelled_copy });
      
      console.warn( 'Error in ALKiln copy button click' );
      console.warn( JSON.stringify( error ));
      // throw(error);
    }
  });

  $(button).on( 'mouseleave blur', async function ( event ) {
    try {
      if ( event.target === button ) {
        
      show_status({ statuses, to_show: status_default });
      }
    } catch ( error ) {
      console.warn( 'Error in ALKiln copy button mouseleave' );
      console.warn( error );
    }
  });
}

function show_status({ statuses, to_show }) {
  /**  */
  for ( let status of statuses ) {
    if ( status === to_show ) { continue; }
    $(status).hide();
  }
  $(to_show).show();
  return to_show;
};
