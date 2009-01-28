package Nasta::Dispatch;
use base 'CGI::Application::Dispatch';
use Config::YAML;

sub dispatch_args {
	my $c = Config::YAML->new(config => 'config/config.yml');
	my @routes;
	my $rts = $c->get_routes;
	foreach my $r (@{$rts}){
	    foreach my $h (keys %$r){
            push(@routes, $h, $r->{$h});
        }
	}
	unshift(@routes, '/', {app=> 'Home', rm=> 'index'});
	return {
		prefix      => $c->get_dispatch_prefix,
		args_to_new => { cfg_file => 'config/config.yml', TMPL_PATH => $c->get_dispatch_tmpl_path,  },
		debug     => $c->get_dispatch_debug,
		table       => [@routes],
		error_document => 'http://errors.fuseful.com/%s',
	};
}

1;
