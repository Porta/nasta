package Nasta;
use base 'CGI::Application';

use CGI::Application::Plugin::ConfigAuto (qw/cfg/);
use CGI::Application::Plugin::Redirect;
use CGI::Application::Plugin::Routes;
use CGI::Application::Plugin::Session;

use Data::Dumper;

#use Nasta::Views qw(template);
use Nasta::Models;


sub start {
    my $self = shift;
    return $self->dump_html;
}

1;