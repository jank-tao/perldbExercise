

package Storage;

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
	my $object = new testDB();
	my $ref_arr = $object->GetStorageColumn($column);
	return $ref_arr;
}
1;