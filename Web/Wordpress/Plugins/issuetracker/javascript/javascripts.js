function toggle_star(issue_id) {
	star = jQuery('#star_'+issue_id);
	new_src = PLUGIN_URI + (star.attr('src') === PLUGIN_URI + 'images/star_on.gif' ? 'images/star_off.gif' : 'images/star_on.gif');
	star.attr('src', PLUGIN_URI + 'images/loading16.gif');	    
        
        jQuery.post(POST_GUID+'do=qdo&qdo=toggle_star&issue_id=' + issue_id, function() {
		star.attr('src', new_src);
	});
}