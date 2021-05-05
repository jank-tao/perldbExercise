#!/usr/bin/perl
BEGIN {
	push( @INC, './Model/' );
	push( @INC, './Table/' );
	push( @INC, '/home/C5323461/perl5/lib/perl5/x86_64-linux-gnu-thread-multi');
	push( @INC, './' );
	push( @INC, '/home/C5323461/perl5/lib/perl5' );
	push( @INC, '/home/C5323461/.cpanm');
}
use main;
use HTML::Template;

# open the html template
my $template = HTML::Template->new(filename => './View/main.tmpl');

print "Content-Type: text/html\n\n";

my $request_method = $ENV{'REQUEST_METHOD'};
if ($request_method eq 'POST') {
	read(STDIN, $query_string, $ENV{'CONTENT_LENGTH'});
	#print "query_string: $query_string\n";
	my @pairs = split('&', $query_string);
	local $attr = {};
	foreach $pair (@pairs) {
		my ($name, $value) = split('=', $pair);
		$attr{$name} = $value;
		# print "name is: $name\t";
		# print "value is: $value\n";
	}
	#print "key_value:" . %$attr . "\n";
	if ( exists($attr{"select"}) ) {
		my $ref = &readAllFromStorage();
		$template->param(GETDATA => $ref);
	} elsif ( exists($attr{"insert"}) ) {
		&createStorage({name => $attr{name}, capacity => $attr{capacity}});
	} elsif ( exists($attr{"delete"}) ) {
		&deleteStorageByName({name => $attr{sto_name},});
	} elsif ( exists($attr{"update"}) ) {
		&updateCapacityStorageByName({name => $attr{name}, capacity => $attr{capacity}});
	} elsif ( exists($attr{"server_select"}) ) {
		$template->param(SERVER_DETAIL => &readAllFromServer());
	} elsif ( exists($attr{"server_insert"}) ) {
		&createServer({name => $attr{name}, operating_system => $attr{operating_system}, storage_name => $attr{storage_name}});
	} elsif ( exists($attr{"server_delete"}) ) {
		&deleteServerByName({name => $attr{vm_name},});
	} elsif ( exists($attr{"server_update"}) ) {
		&updateStoNameServerByName({name => $attr{vm_name}, storage_name => $attr{storage_name}});
	} else {
		print "i am others\n";
	}

} else {
	print "where fk i am ?\n";
}

# print "---\n";
# print defined(param('delete'));
# print "---\n";

# send the obligatory Content-Type and print the template output
print $template->output;