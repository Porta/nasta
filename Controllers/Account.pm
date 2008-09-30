package Controllers::Account;
use base 'Nasta';

sub login : Runmode {
    my $self     = shift;
    my $template = template('main.htm');
    my $user     = new User;
    $user->name('mike');
    $template->param( name => $user->name );
    return $template->output;
}

1;
