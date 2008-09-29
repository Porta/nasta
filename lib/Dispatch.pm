package Dispatch;
use base 'CGI::Application::Dispatch';


CGI::Application::Dispatch->dispatch(
	prefix      => 'Controlers',
	args_to_new => {
		cfg_file => 'config/config.yml'
	},
	table		=> [
		''			=> { app => 'Home', rm => 'index'},
		'/login'		=> { app => 'Account', rm => 'login' },
		'/logout'		=> { app => 'Account', rm => 'logout' },
	]
);

1;