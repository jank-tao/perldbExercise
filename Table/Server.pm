package Server;

use strict;
use warnings;
use testDB;


sub new {
	my $class = shift;
	my $self = {
		_name             => undef,
		_operating_system => undef,
		_storage_name     => undef,
		_checksum         => undef,
		_create_time      => undef,
		_update_time      => undef,
	};

	bless($self, $class);
	return $self;
}

sub getInstance {
	my $obj = Server->new();
	return $obj;
}

sub readName {
	my ($self) = @_;
	my $object = new testDB();
	return $object->GetServerName();
}

sub readAll {
	my ($self) = @_;
	my $object = new testDB();
	return $object->GetServerAll();
}

sub createData {
	my ($self) = @_;
	my $obj = new testDB();
	return $obj->InsertIntoServer($self);
}

sub deleteByName {
	my ($self) = @_;
	my $obj = new testDB();
	return $obj->DeleteFromServer($self);
}

sub updateStoNameByName {
	my ($self) = @_;
	my $obj = new testDB();
	return $obj->UpdateServerByName($self);
}

1;