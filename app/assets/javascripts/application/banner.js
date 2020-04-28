function banner_ready()
{
	if ($(".banner.vertical-banner").length > 0) {
		if (typeof(banner_get) == "function") {
			banner_get(".banner.vertical-banner", "vertical_banner");
		}
	}
}
$(document).ready(banner_ready);
