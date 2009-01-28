package User;
use base 'Jorge::Extended';

#Insert any dependencies here.
#Example:
use Status;
use Users;
use strict;

sub _fields {
	
	my $table_name = 'User';
	
	my @fields = qw(
		Id
		Pass
		Date
		Md5
		Email
	);

	my %fields = (
		Id => { pk => 1, read_only => 1 },
		Status => { class => new Status},
		Date => { datetime => 1},
	);

	return [ \@fields, \%fields, $table_name ];
}

sub before_insert{
    my $self = shift;
    $self->{Md5} = $self->encodeMd5('Email');
    return 1;
}

sub before_save {
    my $self = shift;
    foreach my $f (@{$self->_fields->[0]}){
        $self->{$f} = Common->sanitize($self->{$f});
    }
    return 1;
}
1;
