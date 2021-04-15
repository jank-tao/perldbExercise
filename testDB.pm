#!/usr/bin/perl

package testDB;

use strict;
use warnings;
use DBI;

sub new {
	my $class = shift;
	my $self = {
		_driver        => "Pg",
		_database_name => "exampledb",
		_host          => "127.0.0.1",
		_port          => "5432",
		_db_user       => "dbuser",
		_db_passwd     => "password",

		_dbh           => undef,
	};
	bless $self, $class;
	return $self;
}

sub Conn {
	my ( $self ) = @_;
	my $database = "dbi:$self->{_driver}:dbname=$self->{_database_name}; host=$self->{_host}; port=$self->{_port}";


	my $dbh = $self->{_dbh} = DBI->connect($database, $self->{_db_user}, $self->{_db_passwd}) or die "cant connect!";

	if ($dbh) {
		print "pgconnect ok!\n";
		print "my $dbh->port();\n";
	}
	else {
		print "pgconnect false!\n";
		print "my $dbh->port();\n";
	}
	return 0;
}

# my $driver = "Pg";
# my $database_name = "exampledb";
# my $host = "127.0.0.1";
# my $port = "5432";
# my $database = "dbi:$driver:dbname=$database_name; host=$host; port=$port";
# my $db_user = "dbuser";
# my $db_passwd = "password";

# my $dbh = DBI->connect($database, $db_user, $db_passwd) or die "cant connect!";
# if ($dbh) {
# 	print "pgconnect ok!\n";
# 	print "my $dbh->port();\n";
# }
# else {
# 	print "pgconnect false!\n";
# 	print "my $dbh->port();\n";
# }

sub SetNewConn {
	my ($self, %h_info) = @_;
}

sub Prepare {
	my $sql = shift;

}

sub SelectAll {
	my ($self, $table_name) = @_;
	my $sql = "select * from $table_name";
	my $sth = $self->{_dbh}->prepare($sql) or die "Syntax error: $!\n";
	$sth->execute();
	while (my @row = $sth->fetchrow_array()) {
		print join("\t", @row) . "\n";
	}
	# my @arr = $sth->fetchrow_array();
	# $sth->finish();
	# return @arr;


}

sub Do {

}

sub DisConn {
	my ($self) = @_;
	$self->{_dbh}->disconnect();
}


# my $table_name = 'school_tbl';
# my $sql = "select * from $table_name";
# my $sth = $dbh->prepare($sql) or die "Syntax error: $!\n";
# $sth->execute();
#
# while (my @row = $sth->fetchrow_array()) {
# 	print join("\t", @row) . "\n";
# }
#
# $sth->finish();
# $dbh->disconnect();

1;