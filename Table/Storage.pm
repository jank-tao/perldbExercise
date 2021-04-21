

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
	my $ref_arr = $object->GetStorageName();
	return $ref_arr;
}

sub readAll {
	my ( $self ) = @_;
	my $object = new testDB();
	my $ref_arr = $object->GetStorageAll();
	return $ref_arr;
}

sub createData {
	my ( $self ) = @_;
	my $obj = new testDB();
	$obj->InsertIntoStorage($self);
}

sub deleteByName {
	my ( $self ) = @_;
	my $obj = new testDB();
	$obj->DeleteFromStorage($self);
}

sub updateCapByName {
	my ( $self ) = @_;
	my $obj = new testDB();
	$obj->UpdateCapByName($self);
}




1;