

package Storage;

use strict;
use warnings;
use testDB;


sub new {
	my $class = shift;
	my $self = {
		_name        => undef,
		_capacity    => undef,
		_create_time => undef,
		_update_time => undef,
	};

	bless ($self, $class);
	return $self;
}

sub getInstance {
	my $obj = Storage->new();
	return $obj;
}

sub readName {
	my ( $self ) = @_;
	my $object = new testDB();
	return $object->GetStorageName();
}

sub readAll {
	my ( $self ) = @_;
	my $object = new testDB();
	return $object->GetStorageAll();
}

sub createData {
	my ( $self ) = @_;
	my $obj = new testDB();
	return $obj->InsertIntoStorage($self);
}

sub deleteByName {
	my ( $self ) = @_;
	my $obj = new testDB();
	return $obj->DeleteFromStorage($self);
}

sub updateCapByName {
	my ( $self ) = @_;
	my $obj = new testDB();
	return $obj->UpdateCapByName($self);
}




1;