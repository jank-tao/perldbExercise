#!/usr/bin/perl

BEGIN {
	push( @INC, './Model/' );
	push( @INC, './Table/' );
}

use strict;
use warnings;
use Time::Moment;
use testDB;
use Storage;
use Server;


sub OutputRows {
	my $ref_rows = shift;
	foreach my $data (@$ref_rows) {
		print join("\t", @$data) . "\n";
	}
}

sub readNameFromStorage {
	my $sto_object = &Storage::getInstance();
	my $ref_rows = $sto_object->readName();
	&OutputRows($ref_rows);
}

sub readAllFromStorage {
	my $sto_object = &Storage::getInstance();
	my $ref_rows = $sto_object->readAll();
	&OutputRows($ref_rows);
}

sub createStorage {
	my $attr = shift;
	my $sto_object = &Storage::getInstance();
	$sto_object->{_name} = $attr->{name};
	$sto_object->{_capacity} = $attr->{capacity};
	$sto_object->createData();
}

sub deleteStorageByName {
	my $attr = shift;
	my $sto_object = &Storage::getInstance();
	$sto_object->{_name} = $attr->{name};
	$sto_object->deleteByName();
}

sub updateCapacityStorageByName {
	my $attr = shift;
	my $sto_object = &Storage::getInstance();
	$sto_object->{_name} = $attr->{name};
	$sto_object->{_capacity} = $attr->{capacity};
	$sto_object->updateCapByName();
}

# -------- storage above --------
# -------- server below  --------

sub readNameFromServer {
	my $server_obj = &Server::getInstance();
	my $ref_rows = $server_obj->readName();
	&OutputRows($ref_rows);
}

sub readAllFromServer {
	my $server_obj = &Server::getInstance();
	my $ref_rows = $server_obj->readAll();
	&OutputRows($ref_rows);
}

sub createServer {
	my $attr = shift;
	my $server_obj = &Server::getInstance();
	$server_obj->{_name} = $attr->{name};
	$server_obj->{_operating_system} = $attr->{operating_system};
	$server_obj->{_storage_name} = $attr->{storage_name};
	$server_obj->createData();
}

sub deleteServerByName {
	my $attr = shift;
	my $server_obj = &Server::getInstance();
	$server_obj->{_name} = $attr->{name};
	$server_obj->deleteByName();
}

sub updateStoNameServerByName {
	my $attr = shift;
	my $server_obj = &Server::getInstance();
	$server_obj->{_name} = $attr->{name};
	$server_obj->{_storage_name} = $attr->{storage_name};
	$server_obj->updateStoNameByName();
}


#&readNameFromStorage();
#&readAllFromStorage();
#&createStorage({name => 'sto88', capacity => 200});
#&deleteStorageByName({name => 'sto1',});
#&updateCapacityStorageByName({name => 'sto1', capacity => 233});

#&readNameFromServer();
#&readAllFromServer();
#&createServer({name => 'vm88', operating_system => 'Windows8', storage_name => 'sto3'});
#&deleteServerByName({name => 'vm8',});
#&updateStoNameServerByName({name => 'vm1', storage_name => 'sto2'});