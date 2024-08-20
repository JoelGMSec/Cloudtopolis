<?php

//START CONFIG
$CONN['user'] = 'MYSQL_USER';
$CONN['pass'] = 'MYSQL_PASSWORD';
$CONN['server'] = 'MYSQL_HOST';
$CONN['db'] = 'MYSQL_DB';
$CONN['port'] = 'MYSQL_PORT';

$PEPPER = [
  "__PEPPER1__",
  "__PEPPER2__",
  "__PEPPER3__",
  "__CSRF__"
];

$INSTALL = true; //set this to true if you config the mysql and setup manually

