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

# fill in some parameters
# $template->param(HOME => $ENV{HOME});
# $template->param(PATH => $ENV{PATH});

# local ($buffer, @pairs, $pair, $name, $value, %FORM);
# $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
# if ($ENV{'REQUEST_METHOD'} eq "POST") {
# 	read(STDIN, $buffer, $ENV{CONTENT_LENGTH});
# } else {
# 	$buffer = $ENV{'QUERY_STRING'};
# }
#
# @pairs = split(/&/, $buffer);
# foreach $pair (@pairs) {
# 	($name, $value) = split(/=/, $pair);
# 	$value =~ tr/+/ /;
# 	$value =~ s/%(..)/pack("C", hex($1))/eg;
#    $FORM{$name} = $value;
# }
# $name = $FORM{name};
# $url  = $FORM{url};


print "Content-Type: text/html\n\n";

# Select
# my $ref = &readAllFromStorage();
# $template->param(GETDATA => $ref);

# Insert
# my $request_method = $ENV{'REQUEST_METHOD'};
# if ($request_method eq 'POST') {
# 	read(STDIN, $query_string, $ENV{'CONTENT_LENGTH'});
# 	my @pairs = split('&', $query_string);
# 	local $attr = {};
# 	foreach $pair (@pairs) {
# 		my ($name, $value) = split('=', $pair);
# 		$attr{$name} = $value;
# 	}
# 	print %$attr;
# 	&createStorage({name => $attr{name}, capacity => $attr{capacity}});
# } else {
# 	print "what fk i am ?\n";
# }

# Delete
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
		print "i am update\n";
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