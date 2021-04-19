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
		print "postgresql connect successful!\n";
	}
	else {
		print "pgconnect failed!\n";
	}
	return 0;
}


sub SetNewConn {
	my ($self, %h_info) = @_;
}


sub SelectAll {
	my ($self, $table_name) = @_;
	my $sql = "select * from $table_name";
	my $sth = $self->{_dbh}->prepare($sql) or die "Syntax error: $!\n";
	$sth->execute();
	my $ref_arr = $sth->fetchall_arrayref();
	$sth->finish();
	return $ref_arr;
}

sub Do {
	my ( $self, $sql ) = @_;
	my $sth = $self->{_dbh}->prepare($sql) or die "Syntax error: $!\n";
	my $status = $sth->execute();
	# get result here...
	print "sql: $sql\n";
	print "sql execute status: $status\n";
	use Carp::Assert;
	assert($status > 0) if DEBUG;
	$sth->finish();
}

sub DisConn {
	my ($self) = @_;
	$self->{_dbh}->disconnect();
}
1;