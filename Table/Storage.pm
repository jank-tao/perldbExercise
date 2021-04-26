

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

		_o_db        => new testDB(),
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
	return $self->{_o_db}->GetStorageName();
}

sub readAll {
	my ( $self ) = @_;
	return $self->{_o_db}->GetStorageAll();
}

sub createData {
	my ( $self ) = @_;
	return $self->{_o_db}->InsertIntoStorage($self);
}

sub deleteByName {
	my ( $self ) = @_;
	return $self->{_o_db}->DeleteFromStorage($self);
}

sub updateCapByName {
	my ( $self ) = @_;
	return $self->{_o_db}->UpdateCapByName($self);
}




1;