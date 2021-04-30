#!/usr/bin/perl


use strict;
use warnings;
use Test::More 'no_plan';

require_ok "./main.pl";
require_ok "Storage";
require_ok "testDB";


ok ( &readNameFromStorage(), 'test_readNameFromStorage' );
ok ( &readAllFromStorage(), 'test_readAllFromStorage' );
ok ( &createStorage({name => 'sto88', capacity => 200}) >=0, 'test_createStorage' );
ok ( &deleteStorageByName({name => 'sto1',}), 'test_deleteStorageByName' );
ok ( &updateCapacityStorageByName({name => 'sto1', capacity => 233}), 'test_updateCapacityStorageByName' );

ok ( &readNameFromServer(), 'test_readNameFromServer' );
ok ( &readAllFromServer(), 'test_radNameFromServer' );
ok ( &createServer({name => 'vm88', operating_system => 'Windows8', storage_name => 'sto3'}), 'test_createServer' );
ok ( &deleteServerByName({name => 'vm8',}), 'test_deleteServerByName' );
ok ( &updateStoNameServerByName({name => 'vm1', storage_name => 'sto2'}), 'test_updateStoNameServerByName' );

isnt ( &readNameFromStorage(), undef, 'test_isnt_readNameFromStorage' );
isnt ( &createStorage({name => 'sto88', capacity => 200}), undef, 'test_isnt_createStorage' );

like ( &readNameFromStorage(), qr/^\d+$/, 'test_like_readNameFromStorage' );
like ( &createStorage({name => 'sto88', capacity => 200}), qr/^\d+$/, 'test_like_createStorage' );

can_ok ('Storage', 'readName');
can_ok ('Storage', 'readName1');
can_ok ('Storage', 'updateStoNameByName');

#check if it is your father
isa_ok ( &readNameFromStorage(), 'ARRAY');
isa_ok ( [1,2], 'ARRAY');
my $obj = new Storage();
isa_ok ($obj, 'Storage');

my $obj1 = new Storage();
my $obj2 = new Storage();
my $obj3 = new Server();
is_deeply ($obj1, $obj2, 'test_deeply');
is_deeply ($obj1, $obj3, 'test_diffobj_deeply');

pass ('test_pass');


done_testing();