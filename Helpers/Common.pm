package Common;

use URI::Escape qw(uri_unescape);
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1 ");

sub status{
    my $self = shift;
    my $description = shift;
    my $status = new Status;
    $status->Description($description);
    $status->get_by('Description');
    return $status;
}

sub sanitize{
	my $self = shift;
	my $message = shift;
	my $strip_all = shift || 0;
	my $forbidden_words = join('|', qw(script javascript object embed frameset iframe frame applet style));
	my $regexp =
		'<\s*(' .
			$forbidden_words .
		').*?>.*?</(' .
			$forbidden_words
		. ')>';
	$regexp = qr/$regexp/;
	$message =~ s/$regexp//gsi;
	$message =~ s|\n|<br />|gsi;
	#strip all the html tags OR leave only <br/>
	if ($strip_all){
		$message =~ s[<(?!(/?\/>)).*?>][]gsi;
	}else{
		$message =~ s[<(?!(/?br\s?\/>)).*?>][]gsi;
	}
	return uri_unescape($message);
}

sub checkUrl {
	my $self = shift;
	my $url = shift;

	my $req = HTTP::Request->new(POST => $url);
	my $res = $ua->request($req);
	if ($res->is_success){
		return 1;
	}else{
		return 0;
	}
}

1;