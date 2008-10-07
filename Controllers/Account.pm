package Controllers::Account;
use base 'Nasta';

sub setup{
    my $self = shift;
    $self->routes([
        '/login' =>  'login',
        ]);
}

sub login {
    my $self     = shift;
    my $template = $self->load_tmpl('login.htm');
    my $user     = new User;
    $user->name('mike');
    $template->param( name => $user->name );
    return $template->output;
}

1;
