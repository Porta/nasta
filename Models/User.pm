package User;


sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	return $self;
}

sub name{
	my $self = shift;
	my $name = shift;
	$self->{name} = $name if $name;
	return $self->{name};
}
1;
