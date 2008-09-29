package Nasta::Dispatch;
use base 'CGI::Application::Dispatch';

sub dispatch_args{
	return {	
		prefix      => 'Controllers',
		args_to_new => {
			cfg_file	=> 'config/config.yml'
		},
		debug		=> 1,
		table		=> [
			''				=> { app => 'Home', rm => 'index'},
			'login'			=> { app => 'Account', rm => 'login' },
			':app/:rm'		=> {},
		],
	}
};
1;