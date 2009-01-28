package JS;

sub notify_error{
	my $self = shift;
	my %params = @_;
	my $notify = '$("#notifications").removeClass();$("#notifications").addClass("ERROR");';
	my $message = $params{message};
	if ($message){
		$notify .= '$("#notifications").text("'.$message.'");';
	}
	return $notify;
}

1;