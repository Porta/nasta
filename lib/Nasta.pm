package Nasta;
use base 'CGI::Application';

use CGI::Application::Plugin::ConfigAuto (qw/cfg/);
use CGI::Application::Plugin::AutoRunmode;
use Data::Dumper;
use lib '../lib';
use Views qw(template);
use Models;
 
1;