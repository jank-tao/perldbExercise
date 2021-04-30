#!/usr/bin/perl
BEGIN {
	push( @INC, '/home/C5323461/perl5/lib/perl5' );
	push( @INC, './' );
}
use HTML::Template;

# open the html template
my $template = HTML::Template->new(filename => './View/main.tmpl');

# fill in some parameters
$template->param(HOME => $ENV{HOME});
$template->param(PATH => $ENV{PATH});

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




# send the obligatory Content-Type and print the template output
print "Content-Type: text/html\n\n", $template->output;