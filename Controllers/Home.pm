package Controllers::Home;
use base 'Nasta';
use Data::Dumper;

sub index : Runmode {
    my $self     = shift;
    my $template = $self->template;
    $template->param('name' => 'Alfredo');
    return $template->output;
}

1;
