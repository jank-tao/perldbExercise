#!/usr/bin/perl

BEGIN {
	push( @INC, './Model/' );
	push( @INC, './Table/' );
}

use strict;
use warnings;
use Time::Moment;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use testDB;
use Storage;


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



#&readNameFromStorage();
#&readAllFromStorage();
#&createStorage({name => 'sto88', capacity => 200});
#&deleteStorageByName({name => 'sto88',});
#&updateCapacityStorageByName({name => 'sto1', capacity => 233});

