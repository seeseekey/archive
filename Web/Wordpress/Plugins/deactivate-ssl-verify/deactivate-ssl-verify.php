<?php
/*
* Plugin Name: Deactivate SSL Verify
* Description: Deactivate SSL verification
* Author: seeseekey
* Author URI: http://seeseekey.net
* Plugin URI: http://seeseekey.net
*/
add_filter('https_ssl_verify', '__return_false');
add_filter('https_local_ssl_verify', '__return_false');