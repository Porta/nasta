package Nasta;
use base 'CGI::Application';

use CGI::Application::Plugin::ConfigAuto (qw/cfg/);
use CGI::Application::Plugin::AutoRunmode;
use Data::Dumper;

use Nasta::Views qw(template);
use Nasta::Models;

sub start : Runmode {
    my $self = shift;
    return $self->dump_html;
}

1;