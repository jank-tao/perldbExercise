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

		_o_db             => new testDB(),
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
	return $self->{_o_db}->GetServerName();
}

sub readAll {
	my ($self) = @_;
	return $self->{_o_db}->GetServerAll();
}

sub createData {
	my ($self) = @_;
	return $self->{_o_db}->InsertIntoServer($self);
}

sub deleteByName {
	my ($self) = @_;
	return $self->{_o_db}->DeleteFromServer($self);
}

sub updateStoNameByName {
	my ($self) = @_;
	return $self->{_o_db}->UpdateServerByName($self);
}

1;