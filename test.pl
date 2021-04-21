#!/usr/bin/perl

BEGIN {
	push( @INC, './Model/');
}

use strict;
use warnings;
use Time::Moment;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use testDB;
use storage;

# my $object = new testDB();
# my $status = $object->Conn();
#
# sub createSQL {
# 	my $server_tb = 'server';
# 	my $server_name = 'vm9';
# 	my $operating_system = 'Unix';
# 	my $storage_name = 'sto3';
# 	my $checksum = md5_base64($server_name, $operating_system, $storage_name);
# 	my $sql = qq( INSERT INTO $server_tb VALUES ('$server_name', '$operating_system', '$storage_name', '$checksum'); );
# 	$object->Do($sql);
# }
#
# sub readSQL {
# 	my $ref_rows = $object->SelectAll('server');
# 	foreach my $data ( @$ref_rows ) {
# 		print join("\t", @$data) . "\n";
# 	}
# }
#
# sub updateSQL {
# 	my $tb = 'storage';
# 	my $sql = " UPDATE $tb SET capacity = 99 WHERE name = 'sto1' ";
# 	$object->Do($sql);
# }
#
# sub deleteSQL {
# 	my $tb = 'server';
# 	my $sql = " DELETE FROM $tb WHERE name = 'vm2' ";
# 	$object->Do($sql);
# }

sub readColumnFromStorage {
	my $column = shift;
	my $sto_object = new storage();
	my $ref_rows = $sto_object->readColumn($column);
	# got result here...
	foreach my $data (@$ref_rows) {
		print join("\t", @$data) . "\n";
	}
}


&readColumnFromStorage('name');


