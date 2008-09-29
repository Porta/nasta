package Controlers::Account;
use base 'Nasta';

sub login: Runmode{
	my $self = shift;
	my $template = template('main.htm');
	my $user = new User;
	$user->name('mike');
	warn Dumper($user);
	return $self->dump_html;
}

1;
