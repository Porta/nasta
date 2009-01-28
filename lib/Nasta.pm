package Nasta;
use base 'CGI::Application';

use lib 'lib';

use CGI::Application::Plugin::ConfigAuto (qw/cfg/);
use CGI::Application::Plugin::Redirect;
use CGI::Application::Plugin::Routes;
use CGI::Application::Plugin::Session;

use Data::Dumper;

use Nasta::Helpers;
use Nasta::Models;

sub cgiapp_postrun{
    my $self = shift;
    my $output = shift;
    my $p = $self->param('debug');
    if ($p){
        $Data::Dumper::Indent = 3;
        my $r = ref($p);
        $p = Dumper($p) if ref($p);
        $p =~ s|\n|\<br \/\>|gi;
        $p =~ s|\s\s\s\s|\&nbsp\;|gi;
        my $debug = '<span style="position:static;bottom:0px;font-size:10px;padding:10px;"><h5>debug info for: '.$r.' </h5>'.$p.'</span>';
        $$output =~ s|\<!--debug--\>|$debug|;
    }
}


sub start {
    my $self = shift;
    return $self->dump_html;
}

sub error {
	my $self = shift;
	my $error = $self->param('text');
	return Dumper($error);
}

sub checkSession {
	my $self = shift;
	my $session = $self->session;
	return $session->param('logged_user') if $session->param('md5');
	return 0;
}

sub initSession {
	my $self = shift;
	my $user = shift;
	my $session = $self->session;
	$session->param('logged_user', $user);
	$session->param('md5', $user->Md5);
	return $session;
}

1;