package Nasta;
use base 'CGI::Application';

use CGI::Application::Plugin::ConfigAuto (qw/cfg/);
use CGI::Application::Plugin::AutoRunmode;

use Data::Dumper;

#use Nasta::Views qw(template);
use Nasta::Models;

sub start : Runmode {
    my $self = shift;
    return $self->dump_html;
}

sub template : Runmode{
    my $self = shift;
	my $tmpl = shift;
	my $tmpl_path = 'Views/'.($self->get_current_runmode . '.htm' || $tmpl.'htm');
	my $tmpl_file = HTML::Template->new(filename => $tmpl_path, loop_context_vars => 1);
	return $tmpl_file;
}

1;