package Controllers::Home;
use base 'Nasta';

sub index: Runmode {
	my $self = shift;
	my $template = template;
	return $self->dump_html;
}


1;
