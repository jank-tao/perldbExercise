#!/usr/bin/perl

package testDB;

use strict;
use warnings;
use DBI;
use Try::Tiny qw(try catch);

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
	print "sql: $sql\n";
	my $sth = $self->{_dbh}->prepare($sql) or die "Syntax error: $!\n";
	my $inf_rows = 0;
	try {
		$inf_rows = $sth->execute();
	} catch {};
	return ($sth, $inf_rows);
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
	my ($sth, $inf_rows) = $self->doSQL($sql);
	my $ref_arr = $sth->fetchall_arrayref();
	$sth->finish();
	$self->DisConn();
	return ($ref_arr, $inf_rows);
}

sub InsertIntoStorage {
	my ( $self, $sto_obj ) = @_;
	$self->Conn();
	my $name = $sto_obj->{_name};
	my $capacity = $sto_obj->{_capacity};
	my $sql = qq( INSERT INTO storage VALUES ('$name', '$capacity'); );
	my ($sth, $inf_rows) = $self->doSQL($sql);
	$sth->finish();
	$self->DisConn();
	return $inf_rows;
}

sub DeleteFromStorage {
	my ( $self, $sto_obj ) = @_;
	$self->Conn();
	my $name = $sto_obj->{_name};
	my $sql = qq( DELETE FROM storage WHERE name = '$name' );
	my ($sth, $inf_rows) = $self->doSQL($sql);
	$sth->finish();
	$self->DisConn();
	return $inf_rows;
}

sub UpdateCapByName {
	my ( $self, $sto_obj ) = @_;
	$self->Conn();
	my $name = $sto_obj->{_name};
	my $capacity = $sto_obj->{_capacity};
	my $sql = qq( UPDATE storage SET capacity = $capacity WHERE name = '$name' );
	my ($sth, $inf_rows) = $self->doSQL($sql);
	$sth->finish();
	$self->DisConn();
	return $inf_rows;
}

# -------- storage above --------
# -------- server below  --------

sub GetServerName {
	my ( $self ) = @_;
	return $self->GetServerColumn('name');
}

sub GetServerColumn {
	my ( $self, $column ) = @_;
	$self->Conn();
	my $sql = "select $column from server";
	my ($sth, $inf_rows) = $self->doSQL($sql);
	my $ref_arr = $sth->fetchall_arrayref();
	$sth->finish();
	$self->DisConn();
	return ($ref_arr, $inf_rows);
}

sub GetServerAll {
	my ( $self ) = @_;
	return $self->GetServerColumn('*');
}

sub InsertIntoServer {
	my ( $self, $server_obj ) = @_;
	$self->Conn();
	my $name = $server_obj->{_name};
	my $operating_system = $server_obj->{_operating_system};
	my $storage_name = $server_obj->{_storage_name};
	use Digest::MD5 qw(md5 md5_hex md5_base64);
	my $checksum = md5_base64($name, $operating_system, $storage_name);
	my $sql = qq( INSERT INTO server VALUES ('$name', '$operating_system', '$storage_name', '$checksum'); );
	my ($sth, $inf_rows) = $self->doSQL($sql);
	$sth->finish();
	$self->DisConn();
}

sub DeleteFromServer {
	my ( $self, $server_obj ) = @_;
	$self->Conn();
	my $name = $server_obj->{_name};
	my $sql = qq( DELETE FROM server WHERE name = '$name' );
	my ($sth, $inf_rows) = $self->doSQL($sql);
	$sth->finish();
	$self->DisConn();
	return $inf_rows;
}

sub UpdateServerByName {
	my ( $self, $server_obj ) = @_;
	$self->Conn();
	my $name = $server_obj->{_name};
	my $storage_name = $server_obj->{_storage_name};
	my $sql = qq( UPDATE server SET storage_name = '$storage_name' WHERE name = '$name' );
	my ($sth, $inf_rows) = $self->doSQL($sql);
	$sth->finish();
	$self->DisConn();
	return $inf_rows;
}

1;