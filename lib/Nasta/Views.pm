package Nasta::Views;

use HTML::Template;
use Data::Dumper;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(template);

sub template{
	my $tmpl = shift;
	my $tmpl_path = 'Views/'.$tmpl;
	my $tmpl_file = HTML::Template->new(filename => $tmpl_path, loop_context_vars => 1);
	return $tmpl_file;
}

1;
