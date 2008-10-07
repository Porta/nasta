package Controllers::Home;
use base 'Nasta';
use Data::Dumper;

sub setup{
    my $self = shift;
    $self->routes([
        '' =>  'index',
        ]);
}

sub index {
    my $self     = shift;
    my $template = $self->load_tmpl('index.htm');
    $template->param('name' => 'Alfredo');
    return $template->output;
}

1;
