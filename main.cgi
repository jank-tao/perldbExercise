#!/usr/bin/perl
BEGIN {
	push( @INC, 'C:/StrawberryPerl/perl/site/lib/HTML/' );
}
use HTML::Template;

# open the html template
my $template = HTML::Template->new(filename => './View/main.tmpl');

# fill in some parameters
$template->param(HOME => $ENV{HOME});
$template->param(PATH => $ENV{PATH});

# send the obligatory Content-Type and print the template output
print "Content-Type: text/html\n\n", $template->output;