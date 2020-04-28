/**
 * Init slidebars 
 */
function slidebars()
{
	$.slidebars();
}

/**
 * Hook
 */
$(document).ready(slidebars);
$(document).on("page:load", slidebars);