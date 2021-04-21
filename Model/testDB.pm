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

sub DisConn {
	my ($self) = @_;
	$self->{_dbh}->disconnect();
}

sub Do {
	my $sth = &doSQL(@_);
	$sth->finish();
}

sub doSQL {
	my ( $self, $sql ) = @_;
	my $sth = $self->{_dbh}->prepare($sql) or die "Syntax error: $!\n";
	my $status = $sth->execute();
	# get result here...
	print "sql: $sql\n";
	print "sql execute status: $status\n";
	use Carp::Assert;
	assert($status > 0) if DEBUG;
	return $sth;
}

sub GetStorageAll {
	my ( $self ) = @_;
	return $self->GetStorageColumn('*');
}

sub GetStorageName {
	my ( $self ) = @_;
	return $self->GetStorageColumn('name');
}

sub GetStorageColumn {
	my ( $self, $column ) = @_;
	$self->Conn();
	my $sql = "select $column from storage";
	my $sth = $self->doSQL($sql);
	my $ref_arr = $sth->fetchall_arrayref();
	$sth->finish();
	$self->DisConn();
	return $ref_arr;
}

sub InsertIntoStorage {
	my ( $self, $sto_obj ) = @_;
	$self->Conn();
	my $name = $sto_obj->{_name};
	my $capacity = $sto_obj->{_capacity};
	my $sql = qq( INSERT INTO storage VALUES ('$name', '$capacity'); );
	my $sth = $self->doSQL($sql);
	$sth->finish();
	$self->DisConn();
}

sub DeleteFromStorage {
	my ( $self, $sto_obj ) = @_;
	$self->Conn();
	my $name = $sto_obj->{_name};
	my $sql = qq( DELETE FROM storage WHERE name = '$name' );
	my $sth = $self->doSQL($sql);
	$sth->finish();
	$self->DisConn();
}

sub UpdateCapByName {
	my ( $self, $sto_obj ) = @_;
	$self->Conn();
	my $name = $sto_obj->{_name};
	my $capacity = $sto_obj->{_capacity};
	my $sql = qq( UPDATE storage SET capacity = $capacity WHERE name = '$name' );
	my $sth = $self->doSQL($sql);
	$sth->finish();
	$self->DisConn();
}

1;