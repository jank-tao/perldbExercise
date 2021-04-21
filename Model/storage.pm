

package storage;

use strict;
use warnings;
use testDB;


sub new {
	my $class = shift;
	my $self = {
		_name     => undef,
		_capacity => undef,
	};

	bless ($self, $class);
	return $self;
}

sub readColumn {
	my ($self, $column) = @_;
	my $sql = "select $column from storage";

	my $object = new testDB();
	my $status = $object->Conn();
	my $ref_arr = $object->SelectColumn($sql);

	$object->DisConn();
	return $ref_arr;
}
1;