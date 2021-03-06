<?php
/*
  Plugin Name: Issue Tracker
  Plugin URI: http://seeseekey.googlecode.com
  Description: Adds a full issue tracking system to WordPress
  Version: 0.2
  Author: seeseekey
  Author URI: http://seeseekey.net
  License: GPL3
 */
load_plugin_textdomain("issuetracker", false, 'issuetracker/');

//Requires
require('issuetracker-installer.php');

//register our installer
register_activation_hook(__FILE__, 'it_install');

//load language files
load_plugin_textdomain("issuetracker", false, 'issuetracker/languages/');

class issuetracker {

//Vars
    var $message = "";
    var $message_class = "";
//Translation vars
    var $__id = "";
    var $__summary = "";
    var $__description = "";
    var $__type = "";
    var $__status = "";
    var $__category = "";
    var $__assignee = "";
    var $__attachment = "";
    var $__reported_on = "";
    var $__reporter = "";
    var $__comments = "";
    var $__comment = "";
    var $__delete = "";
    //Datestring
    var $dateFormat = "";

//Constructor
    function issuetracker() {
//Init translation vars    
        $this->__id = __("ID", 'issuetracker');
        $this->__summary = __("Summary", 'issuetracker');
        $this->__description = __("Description", 'issuetracker');
        $this->__type = __("Type", 'issuetracker');
        $this->__status = __("Status", 'issuetracker');
        $this->__category = __("Category", 'issuetracker');
        $this->__assignee = __("Assignee", 'issuetracker');
        $this->__attachment = __("Attachment", 'issuetracker');
        $this->__reported_on = __("Reported on", 'issuetracker');
        $this->__reporter = __("Reporter", 'issuetracker');
        $this->__comments = __("comments", 'issuetracker');
        $this->__comment = __("comment", 'issuetracker');
        $this->__delete = __("Delete", 'issuetracker');

        //Datestring
        $this->dateFormat = 'd.m.Y - H:i:s';
        //$this->dateFormat='F jS, Y @ h:i a';
# filter the content -- match the <!--issuetracker--> and work on it
        add_filter('the_content', array(&$this, 'it_output'), 999);

# add action hooks
        add_action('admin_menu', array(&$this, 'admin_menu'));
        add_action('admin_head', array(&$this, 'it_admin_styles'));
        add_action('init', array(&$this, 'it_action_handlers'));
        add_action('wp_head', array(&$this, 'it_styles'));

# make sure jquery is loaded
        wp_enqueue_script('jquery');
    }

    function admin_menu() {
        add_options_page('Issue Tracker Settings', 'Issue Tracker', 'manage_options', 'issuetracker', array(&$this, 'display_options_page'));
        if ((isset($_GET["page"]) && "issuetracker" == $_GET["page"]) || ( isset($_POST["page"]) && "issuetracker" == $_POST["page"]))
            $this->handle_actions();
    }

    function handle_actions() {
        global $wpdb;

        if (!current_user_can('manage_options')) {
            $this->message = __('Sorry you don\'t have the privileges to do this!', 'issuetracker');
            $this->message_class = 'error';
        } else {
            if (isset($_POST["action"]) && "save-settings" == $_POST["action"]) { //save settings
                if (isset($_POST['submit']) && $_POST['submit'] == '1') {
                    //Types
                    $i = 1;
                    $wpdb->query("DELETE FROM {$wpdb->prefix}it_type");
                    if (isset($_POST['type_names']))
                        foreach ($_POST['type_names'] as $k => $v) {
                            $wpdb->query($wpdb->prepare("INSERT INTO {$wpdb->prefix}it_type
											(type_id, type_name, type_colour, type_tracker, type_order) 
											VALUES (%d, %s, %s, 1, %d)", $k, $_POST['type_names'][$k], $_POST['type_colours'][$k], $i++));
                        }

                    //Status
                    $i = 1;
                    $wpdb->query("DELETE FROM {$wpdb->prefix}it_status");
                    if (isset($_POST['status_names']))
                        foreach ($_POST['status_names'] as $k => $v) {
                            $wpdb->query($wpdb->prepare("INSERT INTO {$wpdb->prefix}it_status
											(status_id, status_name, status_colour, status_strike, status_tracker, status_order)
											VALUES (%d, %s, %s, %d, 1, %d)", $k, $_POST['status_names'][$k], $_POST['status_colours'][$k], isset($_POST['status_strikes'][$k]) ? 1 : 0, $i++));
                        }

                    //Category
                    $i = 1;
                    $wpdb->query("DELETE FROM {$wpdb->prefix}it_category");
                    if (isset($_POST['category_names']))
                        foreach ($_POST['category_names'] as $k => $v) {
                            $wpdb->query($wpdb->prepare("INSERT INTO {$wpdb->prefix}it_category
											(category_id, category_name, category_tracker, category_order)
											VALUES (%d, %s, 1, %d)", $k, $_POST['category_names'][$k], $i++));
                        }
                }

                $this->message = __('Settings saved.', 'issuetracker');
                $this->message_class = 'updated';
            } elseif (isset($_POST["action"]) && "import-google-code-csv" == $_POST["action"]) { //import google csv
//check_admin_referer('add-mime-from-file');
                if (isset($_FILES['userfile'])) {
                    if (isset($_FILES['userfile']['error'])) {
//Check Error Codes
                        switch ($_FILES['userfile']['error']) {
                            case UPLOAD_ERR_INI_SIZE:
                                $message = __('The uploaded file exceeds the upload_max_filesize directive in php.ini.', 'issuetracker');
                                break;
                            case UPLOAD_ERR_FORM_SIZE:
                                $message = __('The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form.', 'issuetracker');
                                break;
                            case UPLOAD_ERR_PARTIAL:
                                $message = __('The uploaded file was only partially uploaded.', 'issuetracker');
                                break;
                            case UPLOAD_ERR_NO_FILE:
                                $message = __('No file was uploaded.', 'issuetracker');
                                break;
                            case UPLOAD_ERR_NO_TMP_DIR:
                                $message = __('Missing a temporary folder.', 'issuetracker');
                                break;
                            case UPLOAD_ERR_CANT_WRITE:
                                $message = __('Can\'t write to disk.', 'issuetracker');
                                break;
                        }
                    }

                    if (isset($message)) {
                        $this->message = __('Error', 'issuetracker') . ': ' . $message;
                        $this->message_class = 'error';
                    } else {

//check file spoofing
                        if (!is_uploaded_file($_FILES['userfile']['tmp_name'])) {
                            $message = __('Stop trying to spoof the $_FILES array hacker!', 'issuetracker');
                        } else {
                            $handle = fopen($_FILES['userfile']['tmp_name'], "r");
                            $csvlines = $this->read_csv($handle);
//$mime_file_lines = file($_FILES['userfile']['tmp_name']);
                            if (!$csvlines) {
                                $message = __('Invalid file format', 'issuetracker');
                            }
                        }

//Check CSV Header
//TODO implement
//Import CSV
                        foreach ($csvlines as &$value) {
                            if ($value[0] == "ID")
                                continue;

//Make import robust
                            $summary = $value[7];
                            $issue_time = $value[12];

                            $wpdb->query("INSERT INTO {$wpdb->prefix}it_issue (issue_tracker, issue_type, issue_status, issue_category, issue_reporter, issue_summary, issue_time)
								VALUES (1, 1, 1, 1, 1, \"$summary\", $issue_time)");
//print_r($value);
//break;
                        }

//Message
                        $this->message = __('Import completed.', 'issuetracker');
                        $this->message_class = 'updated';
                    }
                }
            }
        } //else
    }

    function read_csv($fp) {
        while (!feof($fp)) {
            $zeile = fgetcsv($fp, 4096);
            if (count($zeile) >= 2) {
                $csv_array[] = $zeile;
            }
        }
        return $csv_array;
    }

    function it_action_handlers() {
        global $wpdb;

        $user = wp_get_current_user();
        $do = $this->get_request('do');
        $qdo = $this->get_request('qdo');
        
        if ($do && $do == 'qdo' && $qdo) {
            if (!$user->ID) {
                wp_die('You do not have permission to be here. Please login first then try again.');
            }
            
            switch ($qdo) {
                case 'toggle_star':
                    $id = $this->get_request('issue_id');
                    $user = wp_get_current_user();
                    $starred = $wpdb->get_var($wpdb->prepare("SELECT COUNT(*) FROM {$wpdb->prefix}it_starred
														WHERE user_id = %d AND issue_id = %d", $user->ID, $id));
                    if ($starred) {
                        $wpdb->query($wpdb->prepare("DELETE FROM {$wpdb->prefix}it_starred
												WHERE user_id = %d AND issue_id = %d", $user->ID, $id));
                    } else {
                        $wpdb->query($wpdb->prepare("INSERT INTO {$wpdb->prefix}it_starred
							(user_id, issue_id) VALUES (%d, %d)", $user->ID, $id));
                    }
                    die;
                    break;
                case 'delete_issue':
                    if (!current_user_can('manage_options')) {
                        wp_die("You don't have permissions to do that.");
                    }
                    $id = (int) $this->get_request('issue_id');
                    $post_id = (int) $this->get_request('post_id');
                    $wpdb->query($wpdb->prepare("DELETE FROM {$wpdb->prefix}it_comment WHERE comment_issue = %d", $id));
                    $wpdb->query($wpdb->prepare("DELETE FROM {$wpdb->prefix}it_starred WHERE issue_id = %d", $id));
                    $wpdb->query($wpdb->prepare("DELETE FROM {$wpdb->prefix}it_issue WHERE issue_id = %d", $id));
                    $this->it_redirect($this->build_url('', $post_id));
                    break;
                case 'delete_comment':
                    if (!current_user_can('manage_options')) {
                        wp_die("You don't have permissions to do that.");
                    }
                    $post_id = (int) $this->get_request('post_id');
                    $id = $wpdb->get_var($wpdb->prepare("SELECT comment_issue FROM {$wpdb->prefix}it_comment
												WHERE comment_id = %d", $this->get_request('comment_id')));
                    $wpdb->query($wpdb->prepare("DELETE FROM {$wpdb->prefix}it_comment WHERE comment_id = %d", $this->get_request('comment_id')));
                    $this->it_redirect($this->build_url('do=view_issue&issue=' . $id, $post_id));
                    break;
                case 'save_issue':
// will take all other params from _REQUEST
                    $post_content = $wpdb->get_var($wpdb->prepare("SELECT post_content FROM $wpdb->posts WHERE ID = %d", $this->get_request('post_id')));
                    preg_match('/<!--issuetracker-(\d+)-->/', $post_content, $matches);

                    $content = $this->it_save_changes($matches[1]);
                    break;
            }
            die;
        }
    }

    function get_request($index) {
        return isset($_REQUEST[$index]) ? $_REQUEST[$index] : '';
    }

    function it_admin_styles() {
        echo '
	<script type="text/javascript" src="' . plugins_url('javascript/jquery.tablednd.js', __FILE__ ) .'"/>
	<script type="text/javascript" charset="utf-8">
		jQuery(document).ready(function(){
			jQuery("#types_table").tableDnD()
			jQuery("#status_table").tableDnD()
		})
	</script>
	<style type="text/css" media="screen">
		td.dragger {
			background:#ddd;
			border:1px solid white;
			width:1px;
		}
		td.dragger:hover {
			background:#ccc;
		}
	</style>
	';
    }

    function it_styles() {
        echo '
	<link type="text/css" rel="stylesheet" href="' . plugins_url('style.css', __FILE__ ) . '">
	<script type="text/javascript" src="' . plugins_url('javascript/javascripts.js', __FILE__ ) . '"></script>
	
	<script type="text/javascript">
		var PLUGIN_URI = "' . plugins_url('', __FILE__ ) . '/";
		var POST_GUID = "' . $this->build_url() . '";
	</script>
	';
    }

    function user_has_permission($issue_id = 0) {
        if (current_user_can('manage_options')) {
// super admin!
            return true;
        }
        
        if (current_user_can('administrator')) { return true; } // administrator       
        if (current_user_can('editor')) { return true; } // editor
        if (current_user_can('author')) { return true; } // author
        if (current_user_can('contributor')) { return true; } // contributor
        
// has to be the assignee to change
        $issue = $this->it_get_issue($issue_id);
        $user = wp_get_current_user();
        return $issue && $issue->issue_assignee == $user->ID;
    }

    function it_redirect($url) {
// echo '<script type="text/javascript" charset="utf-8">
// 	location.href = "'.$url.'";
// </script>';
// die;
        wp_redirect($url);
    }

    function it_output($content) {
        global $wpdb;
        global $post;

        preg_match('/<!--issuetracker-(\d+)-->/', $content, $matches);

        if (!count($matches))
            return $content;

        $user = wp_get_current_user();

// if (!$user->ID) {
// 	return "<p>Only logged in users can view the issue tracker. Please <a href='".wp_login_url()."'>login</a> and try again.</p>";
// }
// from the post content <!--issuetracker-1--> means id: 1
// it should only match ints anyways, but casting to be super safe
        $tracker_id = (int) $matches[1];

        $do = $this->get_request('do');
        switch ($do) {
            case 'view_issue':
// are we seeing an issue?
                $issue_id = (int) $this->get_request('issue');
                $content = $this->it_view_issue($issue_id);
                break;
            default:
                $content = $this->it_main_list($tracker_id);
                if ($user->ID)
                    $content .= $this->it_changes_form($tracker_id);
        }
        return stripslashes($content);
    }

    function it_get_issues($tracker_id) {
        global $wpdb;
// in all cases should only send an int to here, but just to make sure
        $tracker_id = (int) $tracker_id;

        return $wpdb->get_results("SELECT i.*, t.*, s.*, c.*, u.display_name as assignee_name, u2.display_name as reporter_name
							FROM {$wpdb->prefix}it_issue i
							JOIN {$wpdb->prefix}it_type t ON i.issue_type = t.type_id
							JOIN {$wpdb->prefix}it_status s ON i.issue_status = s.status_id
                                                        JOIN {$wpdb->prefix}it_category c ON i.issue_category = c.category_id
							LEFT JOIN {$wpdb->prefix}users u ON i.issue_assignee = u.ID
							JOIN {$wpdb->prefix}users u2 ON i.issue_reporter = u2.ID
							WHERE i.issue_tracker = '$tracker_id'
							ORDER BY i.issue_id ASC");
    }

    function it_get_issue($id) {
        global $wpdb;
        $id = (int) $id;
        return $wpdb->get_row("SELECT i.*, t.*, s.*, c.*, u.display_name as assignee_name, u2.display_name as reporter_name
						FROM {$wpdb->prefix}it_issue i
						JOIN {$wpdb->prefix}it_type t ON i.issue_type = t.type_id
						JOIN  {$wpdb->prefix}it_status s ON i.issue_status = s.status_id
                                                JOIN {$wpdb->prefix}it_category c ON i.issue_category = c.category_id
						LEFT JOIN {$wpdb->prefix}users u ON i.issue_assignee = u.ID
						JOIN {$wpdb->prefix}users u2 ON i.issue_reporter = u2.ID
						WHERE i.issue_id = '$id'");
    }

    function it_view_issue($id) {
        global $post, $wpdb;

        $issue = $this->it_get_issue($id);

        if (!$issue) {
            return "Couldn't find that issue.";
        }

        $user = wp_get_current_user();
        $strike = $issue->status_strike ? 'strike' : '';
        $issue->issue_time = date($this->dateFormat, $issue->issue_time);
        $plugin_url = plugins_url('', __FILE__) . "/";
        $starred = $wpdb->get_var($wpdb->prepare("SELECT COUNT(*) FROM {$wpdb->prefix}it_starred
											WHERE user_id = %d AND issue_id = %d", $user->ID, $id));

        $delete_link = '';

        if (current_user_can('manage_options')) {
            $delete_link = '
		<div>
			<label><a href="' . $this->build_url('do=qdo&qdo=delete_issue&post_id=' . $post->ID . '&issue_id=' . $id) . '">' . $this->__delete . '</a></label>
		</div>';
        }

        $attachmentLink = content_url() . '/issuetracker/' . $issue->issue_attachment;
        $onoff = $starred ? 'on' : 'off';
        $issue->issue_summary = ($issue->issue_summary);
        $issue->issue_description_bred = nl2br($issue->issue_description);
        $star = !$user->ID ? '' : <<<STAR
	<a href="javascript:toggle_star({$issue->issue_id})"><img id="star_{$issue->issue_id}" src="{$plugin_url}images/star_{$onoff}.gif" /></a>
STAR;
        $content = <<<HTML
	<div class="issuetracker issues" id="response-div">
		<div>
			<label>{$this->__id}:</label>
			<span>{$issue->issue_id} $star</span>
		</div>
		<div>
			<label>{$this->__summary}:</label>
			<span>{$issue->issue_summary}</span>
		</div>
		<div>
			<label>{$this->__type}:</label>
			<span style="background:#{$issue->type_colour}">{$issue->type_name}</span>
		</div>
                <div>
			<label>{$this->__category}:</label>
			<span>{$issue->category_name}</span>
		</div>
		<div>
			<label>{$this->__status}:</label>
			<span style="background:#{$issue->status_colour};" class="$strike">{$issue->status_name}</span>
		</div>
		
		<div>
			<label>{$this->__reported_on}:</label>
			<span>{$issue->issue_time}</span>
		</div>
		<div>
			<label>{$this->__reporter}:</label>
			<span>{$issue->reporter_name}</span>
		</div>

		<div>
			<label>{$this->__assignee}:</label>
			<span>{$issue->assignee_name}</span>
		</div>
                <div>
			<label>{$this->__attachment}:</label>
			<span><a href="$attachmentLink">{$issue->issue_attachment}</a></span>
		</div>
		<div>
			<label>{$this->__description}:</label>
			<span>{$issue->issue_description_bred}</span>
		</div>
		$delete_link
	</div>
HTML;
// again, just making sure we're safe
        $id = (int) $id;
        $comments = $wpdb->get_results("SELECT c.*, u.display_name, u.user_email
									FROM {$wpdb->prefix}it_comment c
									JOIN {$wpdb->prefix}users u ON c.comment_poster = u.ID
									JOIN {$wpdb->prefix}it_issue i ON c.comment_issue = i.issue_id
									WHERE i.issue_id = '$id'
									ORDER BY c.comment_time ASC");
        $content .= '<div id="comments"><h3 id="comments-title">' . number_format(count($comments)) . ' ' . $this->__comments . '</h3> <ol class="commentlist">';

        foreach ($comments as $comment) {
            $attachmentLinkComment = content_url() . "/issuetracker/" . $comment->comment_attachment;

            $comment->comment_body = ($comment->comment_body);
            $comment->comment_time = date($this->dateFormat, $comment->comment_time);
            $delete_url = $this->build_url('do=qdo&qdo=delete_comment&post_id=' . $post->ID . '&comment_id=' . $comment->comment_id);
            $delete_link = current_user_can('manage_options') ? " <a class='comment-edit-link' href='$delete_url'>({$this->__delete})</a>" : '';
            $comment->comment_body = nl2br($comment->comment_body);

            $content .= <<<HTML
		<li class="comment"> 
			<div> 
				<div class="comment-author"> 				
					<cite>{$comment->display_name}</cite> / {$comment->comment_time}$delete_link	
				</div>				
HTML;




            $content .= <<<HTML
				<div class="comment-body">{$comment->comment_body}</div>
HTML;

            if ($comment->comment_attachment) {
                $content .= <<<HTML
                                    <p>
                                    <div class="comment-attachment">
                                {$this->__attachment}: <a href="$attachmentLinkComment">{$comment->comment_attachment}</a>
                                        </div>
                                        </p>
HTML;
            }


            $content .=<<<HTML
			</div>
		</li>
HTML;
        }
        $content .= '</ol></div>';

        if ($user->ID) {
            $content .= $this->it_changes_form($issue->issue_tracker, $issue);
        }

        return $content;
    }

    function it_save_changes($tracker_id) {
        global $wpdb, $post;

        $user = wp_get_current_user();
        $changes = array();
        $issue_id = (int) $this->get_request('issue_id');
        $post_id = (int) $this->get_request('post_id');
        $and_more = '';

        if ($issue_id) { //edit existing issue
// we're either commenting or making a change, figure out the changes first
            $issue = $this->it_get_issue($issue_id);
            $and_more = 'do=view_issue&issue=' . $issue_id;

            if ($this->user_has_permission($issue_id)):
// lets compare the changes?
                $new = new stdClass;
                $new->issue_summary = $this->get_request('summary');
                $new->issue_type = $this->get_request('type');
                $new->issue_status = $this->get_request('status');
                $new->issue_category = $this->get_request('category');
                $new->issue_description = $this->get_request('description');
                $new->issue_assignee = $this->get_request('assignee');

                if ($new->issue_summary != $issue->issue_summary) {
                    $changes[] = "<strong>{$this->__summary}</strong> {$new->issue_summary}";
                }

                if ($new->issue_type != $issue->issue_type) {
                    $old_type = $wpdb->get_row("SELECT type_name, type_colour FROM {$wpdb->prefix}it_type WHERE type_id={$issue->issue_type}");
                    $id = (int) $new->issue_type;
                    $new_type = $wpdb->get_row("SELECT type_name, type_colour FROM {$wpdb->prefix}it_type WHERE type_id=$id");
                    $changes[] = "<strong>{$this->__type}</strong> <span style='background:#{$old_type->type_colour}'>{$old_type->type_name}</span> > <span style='background:#{$new_type->type_colour}'>{$new_type->type_name}</span>";
                }

                if ($new->issue_status != $issue->issue_status) {
                    $old_status = $wpdb->get_row("SELECT status_name, status_colour, status_strike FROM {$wpdb->prefix}it_status WHERE status_id={$issue->issue_status}");
                    $strike1 = $old_status->status_strike ? 'strike' : '';
                    $id = (int) $new->issue_status;
                    $new_status = $wpdb->get_row("SELECT status_name, status_colour, status_strike FROM {$wpdb->prefix}it_status WHERE status_id=$id");
                    $strike2 = $new_status->status_strike ? 'strike' : '';
                    $changes[] = "<strong>{$this->__status}</strong> <span style='background:#{$old_status->status_colour}' class='$strike1'>{$old_status->status_name}</span> > <span style='background:#{$new_status->status_colour}' class='$strike2'>{$new_status->status_name}</span>";
                }

                if ($new->issue_description != $issue->issue_description) {
                    $changes[] = "<strong>{$this->__description}</strong> {$new->issue_description}";
                }

                if ($new->issue_assignee != $issue->issue_assignee) {
                    $id = (int) $new->issue_assignee;
                    $new_assignee_name = '--';
                    
                    if ($id) {
                        $new_assignee = $wpdb->get_row("SELECT display_name FROM $wpdb->users WHERE ID=$id");
                        $new_assignee_name = $new_assignee->display_name;
                        $wpdb->query("INSERT INTO {$wpdb->prefix}it_starred (user_id, issue_id)
								VALUES ($id, $issue->issue_id)");
                    }
                    
                    $changes[] = "<strong>{$this->__assignee}</strong> {$new_assignee_name}";
                }

// write the new issue details
                $wpdb->query($wpdb->prepare("UPDATE {$wpdb->prefix}it_issue
										SET issue_summary = %s,
										issue_type = %d,
										issue_status = %d,
										issue_category = %d,
										issue_description = %s,
										issue_assignee = %d
										WHERE issue_id = %d", $new->issue_summary, $new->issue_type, $new->issue_status, $new->issue_category, $new->issue_description, $new->issue_assignee, $issue_id));
            endif;

            $changes_stuff = count($changes) ? '<p>' . implode('<br />', $changes) . '</p>' : '';
            $comment = $changes_stuff . '<p>' . $this->get_request('comment') . '</p>';

//, and make the comment
            if (strlen($comment) > 7 || $_FILES['userfile']["name"]) {
// first make sure this plugin has not been submitted recently
                $seconds = 5;
                $already_made = $wpdb->get_var($wpdb->prepare("SELECT COUNT(*) FROM {$wpdb->prefix}it_comment
														WHERE comment_issue = %d AND comment_poster = %d 
																		AND comment_body = %s AND comment_time > %d", $issue_id, $user->ID, $comment, time() - $seconds));
                if (!$already_made) {
//Upload file
                    $success = false;
                    $message;
                    $filename;

                    if ($_FILES['userfile']["name"]) {
                        $this->putUploadIntoFolder($_FILES, $success, $message, $filename);
                    } else { //no file to upload
                        $success = true;
                    }

// we're submitting a new issue, save to db
                    if ($success) {
                        $wpdb->query($wpdb->prepare("INSERT INTO {$wpdb->prefix}it_comment
									(comment_issue, comment_poster, comment_body, comment_time, comment_attachment)
									VALUES (%d, %d, %s, %d, %s)", $issue_id, $user->ID, $comment, time(), $filename));
                        $this->announce_change_to_stars($comment, $issue_id);
                    }
                }
            }
        } else { //create new issue
//Upload file
            $success = false;
            $message;
            $filename;

            if ($_FILES['userfile']["name"]) {
                $this->putUploadIntoFolder($_FILES, $success, $message, $filename);
            } else { //no file to upload
                $success = true;
            }

// we're submitting a new issue, save to db
            if ($success) {
                $can = $this->user_has_permission(0);
                $default_status = $wpdb->get_var("SELECT status_id FROM {$wpdb->prefix}it_status ORDER BY status_order ASC, status_id ASC LIMIT 0, 1");

                $wpdb->query($wpdb->prepare("
			INSERT INTO {$wpdb->prefix}it_issue
			(issue_tracker, issue_summary, issue_type, issue_status, issue_category, issue_time, issue_reporter, issue_description, issue_assignee, issue_attachment)
			VALUES (%d, %s, %d, %d, %d, %d, %d, %s, %d, %s)", $tracker_id, $this->get_request('summary'), $this->get_request('type'), $can ? $this->get_request('status') : $default_status, $this->get_request('category'), time(), $user->ID, $this->get_request('description'), $can ? $this->get_request('assignee') : 0, $filename));

                $wpdb->query($wpdb->prepare("INSERT INTO {$wpdb->prefix}it_starred (user_id, issue_id) VALUES (%d, %d)", $user->ID, $wpdb->insert_id));
            }
        }

        $this->it_redirect($this->build_url($and_more, $post_id));
    }

    function putUploadIntoFolder($files, &$success, &$message, &$filename) {
        if (isset($files['userfile'])) {
            if (isset($files['userfile']['error'])) {
//Check Error Codes
                switch ($files['userfile']['error']) {
                    case UPLOAD_ERR_INI_SIZE:
                        $message = __('The uploaded file exceeds the upload_max_filesize directive in php.ini.', 'issuetracker');
                        break;
                    case UPLOAD_ERR_FORM_SIZE:
                        $message = __('The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form.', 'issuetracker');
                        break;
                    case UPLOAD_ERR_PARTIAL:
                        $message = __('The uploaded file was only partially uploaded.', 'issuetracker');
                        break;
                    case UPLOAD_ERR_NO_FILE:
                        $message = __('No file was uploaded.', 'issuetracker');
                        break;
                    case UPLOAD_ERR_NO_TMP_DIR:
                        $message = __('Missing a temporary folder.', 'issuetracker');
                        break;
                    case UPLOAD_ERR_CANT_WRITE:
                        $message = __('Can\'t write to disk.', 'issuetracker');
                        break;
                }
            }

            if (isset($message)) {
                $this->message = __('Error', 'issuetracker') . ': ' . $message;
                $this->message_class = 'error';
            } else {

//check file spoofing
                if (!is_uploaded_file($_FILES['userfile']['tmp_name'])) {
                    $message = __('Stop trying to spoof the $_FILES array hacker!', 'issuetracker'); 
                } else {
                    $filename = basename($_FILES['userfile']['name']);

                    $uploaddir = content_url() . "/issuetracker/";
                    $uploadfile = $uploaddir . $filename;

                    //check if file with this name exist
                    if (file_exists($uploadfile)) {
                        $path_parts = pathinfo($uploadfile);
                        $i = 2;

                        while (true) {
                            $filename = $path_parts['filename'] . '-' . $i . $path_parts['extension'];
                            $newFilename = $uploaddir . $filename;

                            if (file_exists($newFilename) == false) {
                                $uploadfile = $newFilename;
                                break;
                            } else {
                                $i++;
                            }
                        }
                    }

                    if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
                        $success = true;
                    } else {
                        $this->message = __("Possible file upload attack!", 'issuetracker');
                        $this->message_class = 'error';
                    }
                }
            }
        }
    }

    function it_changes_form($tracker_id, $issue = null) {
        global $wpdb, $post;

        $user = wp_get_current_user();

        if ($issue) {
            $form_h3 = "";
            $form_submit = __('Save changes', 'issuetracker');
        } else {
            $issue = new stdClass;
            $issue->issue_id = 0;
            $issue->issue_summary = '';
            $issue->issue_description = '';
            $issue->type_id = 0;
            $issue->status_id = 0;
            $issue->issue_assignee = 0;
            $form_h3 = __('Submit new issue', 'issuetracker');
            $form_submit = __('Submit', 'issuetracker');
        }

        $types = $wpdb->get_results("SELECT * FROM {$wpdb->prefix}it_type 
								WHERE type_tracker = $tracker_id
								ORDER BY type_order ASC, type_id ASC");
        $types_options = '';
        foreach ($types as $type) {
            $sel = $type->type_id == $issue->type_id ? ' selected' : '';
            $types_options .= "<option value={$type->type_id}{$sel}>{$type->type_name}</option>";
        }

//category
        $categories = $wpdb->get_results("SELECT * FROM {$wpdb->prefix}it_category 
								WHERE category_tracker = $tracker_id
								ORDER BY category_order ASC, category_id ASC");

        $categories_options = '';
        foreach ($categories as $category) {
            $sel = $category->category_id == $issue->category_id ? ' selected' : '';
            $categories_options .= "<option value={$category->category_id}{$sel}>{$category->category_name}</option>";
        }

        $comment_area = '';

        if ($issue->issue_id) {
            $comment_area = <<<HTML
		<p ><label for="comment">{$this->__comment}:</label><br/><textarea id="comment" name="comment" cols="45" rows="8" ></textarea></p>	
                    
		<p>
		{$this->__attachment}:<br/>
		<input type="hidden" name="MAX_FILE_SIZE" value="3000000"> <!-- 3 MB -->
		<input id="attachment" name="userfile" type="file" />
		</p>
HTML;
        }

        $issue_options = '';

        if ($this->user_has_permission($issue->issue_id)) {

            $statuses = $wpdb->get_results("SELECT * FROM {$wpdb->prefix}it_status 
									WHERE status_tracker = $tracker_id
									ORDER BY status_order ASC, status_id ASC");
            $status_options = '';
            foreach ($statuses as $status) {
                $sel = $status->status_id == $issue->status_id ? ' selected' : '';
                $status_options .= "<option value={$status->status_id}{$sel}>{$status->status_name}</option>";
            }

            $users = $wpdb->get_results("SELECT u.ID, u.display_name, m.meta_value FROM $wpdb->users u, $wpdb->usermeta m WHERE u.ID=m.user_id AND m.meta_key LIKE 'wp_user_level' ORDER BY u.display_name");
            
            $users_options = '<option value=0></option>';
            foreach ($users as $user) {
                //Check if user contributer or greater
                $userLevel=$user->meta_value;
                $userLevelInt = (int)$userLevel;
                if($userLevelInt<1) continue;
                
                $sel = $user->ID == $issue->issue_assignee ? ' selected' : '';
                $users_options .= "<option value={$user->ID}{$sel}>{$user->display_name}</option>";
            }

            $issue_options = <<<OPTS
<p ><label for="summary">{$this->__summary}:</label><br/><input id="summary" name="summary" type="text" value="{$issue->issue_summary}" size="30" aria-required='true' /></p> 
<p ><label for="description">{$this->__description}:</label><br/><textarea id="description" name="description" cols="45" rows="8">{$issue->issue_description}</textarea></p>
<p ><labelfor="type">{$this->__type}:</label><select name="type" id="type" >{$types_options}</select></p>
<p ><label for="status">{$this->__status}:</label><select name="status" id="status" >{$status_options}</select></p>
<p ><label for="category">{$this->__category}:</label><select name="category" id="category" >{$categories_options}</select></p>
<p ><label for="assignee">{$this->__assignee}:</label><select name="assignee" id="assignee" >{$users_options}</select></p>
OPTS;
        } else if (!$issue->issue_id) {
            $issue_options = <<<OPTS
<p ><label for="summary">{$this->__summary}:</label><input id="summary" name="summary" type="text" value="{$issue->issue_summary}" size="30" aria-required='true' /></p> 
<p ><label for="description">{$this->__description}:</label><textarea id="description" name="description" cols="45" rows="8">{$issue->issue_description}</textarea></p>
<p ><labelfor="type">{$this->__type}:</label><select name="type" id="type" >{$types_options}</select></p>
<p ><label for="category">{$this->__category}:</label><select name="category" id="category" >{$categories_options}</select></p>
OPTS;
        }
        $action = $this->build_url('do=qdo&qdo=save_issue&post_id=' . $post->ID);

        $ret .= <<<HTML
        <hr />
	<div id="respond" style="border-top:0;">
	<h3 id="reply-title">{$form_h3}</h3>
	<form enctype="multipart/form-data" action="$action" method="POST" id="commentform">
	    
		<input type="hidden" name="issue_id" value="{$issue->issue_id}" id="issue_id">
		{$comment_area}
		{$issue_options}
HTML;

        if (!$issue->issue_id) {
            $ret .= <<<HTML
		<p>
		{$this->__attachment}:<br/>
		<input type="hidden" name="MAX_FILE_SIZE" value="3000000"> <!-- 3 MB -->
		<input id="attachment" name="userfile" type="file" />
		</p>
HTML;
        }

        $ret .= <<<HTML
		
		<p class="form-submit"> 
			<input name="submit" type="submit" id="submit" value="{$form_submit}" /> 
		</p> 
	</form>
	</div>
HTML;
        return $ret;
    }

    function build_url($uri_string = '', $post_id = 0) {
        if (!$post_id) {
            global $post;
            $post_id = $post->ID;
        }

        $permalink = get_permalink($post_id);
        return $permalink . (strpos($permalink, '?') === false ? '?' : '&') . $uri_string;
    }

    function it_main_list($tracker_id) {
        global $post, $wpdb;

        $user = wp_get_current_user();
        $star = !$user->ID ? '' : <<<STAR
	<th style="width:1%;"> </th>
STAR;
        $content = <<<HTML
	<style type="text/css" media="screen">
		#content table.issuetracker tr th, #content table.issuetracker tr td {
			font-size: 12px;
			padding: 10px;
		}
	</style>
	<table id="issuetracker-$tracker_id" class="issuetracker">
		<tr>
			<th style="width:1%;">{$this->__id}</th>
			<th style="width:95%;">{$this->__summary}</th>
			<th style="width:1%;">{$this->__type}</th>
			<th style="width:1%;">{$this->__category}</th>
			<th style="width:1%;">{$this->__reporter}</th>
			<th style="width:1%;">{$this->__assignee}</th>
			$star
		</tr>
HTML;

        $plugin_url = plugins_url('', __FILE__) . "/";
        $issues = $this->it_get_issues($tracker_id);

        foreach ($issues as $issue) {
            if ($issue->status_strike)
                continue;

            $strike = $issue->status_strike ? 'strike' : '';
            $starred = $wpdb->get_var($wpdb->prepare("SELECT COUNT(*) FROM {$wpdb->prefix}it_starred
												WHERE user_id = %d AND issue_id = %d", $user->ID, $issue->issue_id));
            $onoff = $starred ? 'on' : 'off';
            $url = $this->build_url('do=view_issue&issue=' . $issue->issue_id);
            $issue->issue_summary = ($issue->issue_summary);
            $star = !$user->ID ? '' : <<<STAR
	<td><a href="javascript:toggle_star({$issue->issue_id})"><img id="star_{$issue->issue_id}" src="{$plugin_url}images/star_{$onoff}.gif" /></a></td>	
STAR;
            $content .= <<<HTML
		<tr style="background:#{$issue->status_colour};" >
			<td>{$issue->issue_id}</td>
			<td class="$strike"><a href="$url">{$issue->issue_summary}</a></td>
			<td style="background:#{$issue->type_colour};">{$issue->type_name}</td>
                        <td>{$issue->category_name}</td>
			<td>{$issue->reporter_name}</td>
			<td>{$issue->assignee_name}</td>
			$star
		</tr>
HTML;
        }
        $content .= "</table>";

        $statuses = $wpdb->get_results("SELECT * FROM {$wpdb->prefix}it_status WHERE status_tracker = $tracker_id ORDER BY status_order ASC, status_id ASC");
        $arr = array();

        foreach ($statuses as $s) {
            $strike = $s->status_strike ? 'strike' : '';
            $arr[] = "<span style='background:#{$s->status_colour};' class='$strike'>{$s->status_name}</span>";
        }

        $content .= '<p>Status: ' . implode(', ', $arr) . '</p>';

        return $content;
    }

    function announce_change_to_stars($comment, $issue_id) {
        global $wpdb, $post;
        $issue_id = (int) $issue_id;
        $poster = wp_get_current_user();
        $users = $wpdb->get_results($wpdb->prepare("SELECT DISTINCT u.user_email, u.ID FROM $wpdb->users u
										JOIN {$wpdb->prefix}it_starred s ON s.user_id = u.ID
										WHERE s.issue_id = %d AND s.user_id <> %d", $issue_id, $poster->ID));
        $headers = "MIME-Version: 1.0\n" .
                "Content-Type: text/html; charset=\"" . get_option('blog_charset') . "\"\n";
        
        foreach ($users as $user) {
            wp_mail($user->user_email, 
                    '[IssueTracker] ' . __('Changes to issue', 'issuetracker') . ' #' . $issue_id,
                    '<p>' . __('New comment by', 'issuetracker') . ' ' . $poster->display_name . '</p>' . $comment . 
                    '<p>' . __('Click here to go to the issue', 'issuetracker') . ': ' 
                    . $this->build_url('do=view_issue&issue=' . $issue_id, (int) $this->get_request('post_id')) 
                    . '</p>', $headers);
        }
    }

    function display_options_page() {
        global $wpdb;

//must check that the user has the required capability 
        if (!current_user_can('manage_options')) {
            wp_die(__('You do not have sufficient permissions to access this page.', 'issuetracker'));
        }

        if (!current_user_can('manage_options')) {
            echo '<div id="message" class="updated fade"> <p>Sorry you don\'t have the privileges to do this!</p></div>';
        } else {
            if (strlen($this->message) > 0) {
                ?>
                <div id="message" class="<?php echo $this->message_class; ?> fade">
                    <p><?php echo $this->message; ?></p>
                </div>
                <?php
            }
        }

        echo '<div class="wrap">';
        echo "<h2>" . __('Issue Tracker Settings', 'issuetracker') . "</h2>";
        ?>

        <form name="" method="post" action="">
            <input type="hidden" name="submit" value="1">
            <h3><?php echo $this->__type; ?></h3>
            <a href="" onclick="return append_new_type();"><?php echo __('Add new', 'issuetracker') ?></a>
            <table class="form-table" id="types_table"> 
                <?php
                $types = $wpdb->get_results("SELECT * FROM {$wpdb->prefix}it_type WHERE type_tracker = 1 ORDER BY type_order ASC, type_id ASC");
                foreach ($types as $type) {
                    ?>
                    <tr valign="top"> 
                        <td class="dragger"></td>
                        <td>
                            <input name="type_names[<?php echo $type->type_id ?>]" type="text" id="" value="<?php echo stripslashes($type->type_name) ?>" />
                            <input name="type_colours[<?php echo $type->type_id ?>]" type="text" id="" value="<?php echo $type->type_colour ?>" /> 
                            <a onclick="jQuery(this).parent().parent().remove(); return false;" href=""><?php echo __('delete', 'issuetracker'); ?></a>
                        </td> 
                    </tr>	
                    <?php
                }
                ?>
            </table>
            <script type="text/javascript" charset="utf-8">
                function append_new_type() {
                    new_row = "<tr valign='top'><td class='dragger'></td><td><input name='type_names[]' type='text' /><input name='type_colours[]' type='text' /><a onclick='jQuery(this).parent().parent().remove(); return false;' href=''><?php echo __('delete', 'issuetracker'); ?></a></td></tr>";
                    jQuery('#types_table').append(new_row);
                    jQuery("#types_table").tableDnD()
                    return false;
                }
            </script>

            <h3><?php echo $this->__status; ?></h3>
            <a href="" onclick="return append_new_status();"><?php echo __('Add new', 'issuetracker') ?></a>

            <table class="form-table" id="status_table"> 
                <?php
                $types = $wpdb->get_results("SELECT * FROM {$wpdb->prefix}it_status WHERE status_tracker = 1 ORDER BY status_order ASC, status_id ASC");
                foreach ($types as $status) {
                    ?>
                    <tr valign="top"> 
                        <td class="dragger"></td>
                        <td>
                            <input name="status_names[<?php echo $status->status_id ?>]" type="text" id="" value="<?php echo stripslashes($status->status_name) ?>" />
                            <input name="status_colours[<?php echo $status->status_id ?>]" type="text" id="" value="<?php echo $status->status_colour ?>" /> 
                            <input type="checkbox" name="status_strikes[<?php echo $status->status_id ?>]" <?php echo $status->status_strike ? 'checked' : '' ?>> 
                            <a onclick="jQuery(this).parent().parent().remove(); return false;" href=""><?php echo __('delete', 'issuetracker'); ?></a>
                        </td> 
                    </tr>	
                    <?php
                }
                ?>
            </table>

            <script type="text/javascript" charset="utf-8">
                function append_new_status() {
                    new_row = '<tr valign="top"><td class="dragger"></td><td><input name="status_names[]" type="text" /><input name="status_colours[]" type="text" /> <input type="checkbox" name="status_strikes[]"> <a onclick="jQuery(this).parent().parent().remove(); return false;" href=""><?php echo __('delete', 'issuetracker'); ?></a></td></tr>';
                    jQuery('#status_table').append(new_row);
                    jQuery("#status_table").tableDnD()
                    return false;
                }
            </script>

            <h3><?php echo $this->__category; ?></h3>
            <a href="" onclick="return append_new_category();"><?php echo __('Add new', 'issuetracker') ?></a>

            <table class="form-table" id="category_table"> 
                <?php
                $types = $wpdb->get_results("SELECT * FROM {$wpdb->prefix}it_category WHERE category_tracker = 1 ORDER BY category_order ASC, category_id ASC");
                foreach ($types as $category) {
                    ?>
                    <tr valign="top"> 
                        <td class="dragger"></td>
                        <td>
                            <input name="category_names[<?php echo $category->category_id ?>]" type="text" id="" value="<?php echo stripslashes($category->category_name) ?>" />
                            <a onclick="jQuery(this).parent().parent().remove(); return false;" href=""><?php echo __('delete', 'issuetracker'); ?></a>
                        </td> 
                    </tr>
                    <?php
                }
                ?>
            </table>

            <script type="text/javascript" charset="utf-8">
                function append_new_category() {
                    new_row = '<tr valign="top"><td class="dragger"></td><td><input name="category_names[]" type="text" /> <a onclick="jQuery(this).parent().parent().remove(); return false;" href=""><?php echo __('delete', 'issuetracker'); ?></a></td></tr>';
                    jQuery('#category_table').append(new_row);
                    jQuery("#category_table").tableDnD()
                    return false;
                }
            </script>

            <p class="submit">
                <input type="hidden" name="action" value="save-settings" />
                <input type="submit" name="Submit" class="button-primary" value="<?php _e('Save Changes', 'issuetracker') ?>" />
            </p>
        </form>

        <h3><?php echo __('Import from Google Code Issue Tracker CSV', 'issuetracker') ?></h3><br/>
        <form enctype="multipart/form-data" action="" method="post">
            <?php wp_nonce_field('import-google-code-csv'); ?>
            <input type="hidden" name="MAX_FILE_SIZE" value="30000000" />
            <?php echo __('Select a file containing the CSV export file', 'issuetracker') ?>: <input name="userfile" type="file" />
            <p class="submit">
                <input type="hidden" name="action" value="import-google-code-csv" />
                <input type="submit" value="<?php echo __('Import', 'issuetracker') ?>: &raquo;" class="button-primary" />
            </p>
        </form>

        </div>

        <?php
    }

}

/* Initialise outselves lambda style */
add_action('plugins_loaded', create_function('', 'global $issuetracker; $issuetracker = new issuetracker;'));
?>