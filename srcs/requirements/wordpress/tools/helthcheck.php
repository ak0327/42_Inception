<?php
require_once(__DIR__ . '/wp-load.php');

global $wpdb;
if(!$wpdb->check_connection()) {
    http_response_code(500);
    echo "Database connection error";
    exit();
}

http_response_code(200);
echo "OK";
