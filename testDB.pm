#!/usr/bin/perl -w

use strict;
use warnings;
use DBI;


my $driver = "Pg";
my $database_name = "exampledb";
my $host = "127.0.0.1";
my $port = "5432";
my $database = "dbi:$driver:dbname=$database_name; host=$host; port=$port";
my $db_user = "dbuser";
my $db_passwd = "password";

my $dbh = DBI->connect($database, $db_user, $db_passwd) or die "cant connect!";
if ($dbh) {
	print "pgconnect ok!\n";
	print "my $dbh->port();\n";
} else {
	print "pgconnect false!\n";
	print "my $dbh->port();\n";
}

my $table_name = 'school_tbl';
my $sql = "select * from $table_name";
my $sth = $dbh->prepare($sql) or die "Syntax error: $!\n";
$sth->execute();

# use Data::Dumper;
# while(my $row = $sth->fetchrow_hashref()) {
# 	print Dumper($row);
# }
while ( my @row = $sth->fetchrow_array() ){
	print join("\t", @row) . "\n";
}

$sth->finish();
$dbh->disconnect();