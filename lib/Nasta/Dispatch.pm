package Nasta::Dispatch;
use base 'CGI::Application::Dispatch';
use Config::YAML;
use Data::Dumper;
sub dispatch_args {
    my $c = Config::YAML->new(config => 'config/config.yml');
    warn Dumper($c);
    return {
        prefix      => $c->get_dispatch_prefix,
        args_to_new => { cfg_file => 'config/config.yml' },
        debug       => $c->get_dispatch_debug,
        table       => $c->get_dispatch_table,
    };
}
1;
