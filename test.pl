#!/usr/bin/perl

BEGIN {
	push( @INC, './');
}

use strict;
use warnings;

use testDB;

my $object = new testDB();
my $status = $object->Conn();
my @rows = $object->SelectAll('school_tbl');
# while ( my @row = @rows ) {
# 	print join("\t", @row) . "\n";
# }


$object->DisConn();

