/**
 * Init zoomify 
 */
function zoomify_ready()
{
	$(".zoomify").zoomify();
	/*$(".zoomify").hover(function() {
		$(this).zoomify('zoomIn');
	}, function() {

	});*/
}

/**
 * Hook
 */
$(document).ready(zoomify_ready);
$(document).on("page:load", zoomify_ready);