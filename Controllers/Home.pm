package Controllers::Home;
use base 'Nasta';

sub setup {
	my $self = shift;
	$self->routes([
		'' => 'index',
	]);
}

sub index {
	my $self = shift;
	my $q = $self->query;

	my $main_template = $self->load_tmpl("Views/main.htm");
	my $template = $self->load_tmpl("Views/home.htm");
    my $user = $self->checkSession;
    if ($user) {
        $main_template->param(loggedin => $user->Email);
     }
	$main_template->param(content => $template->output);
	return $main_template->output;
}
1;
