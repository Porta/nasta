package Mailer;
use Data::Dumper;

sub send {
	my $self = shift;
	my %params = @_;
	open SENDMAIL, "|-" , '/usr/sbin/sendmail -t';
	my $return = print SENDMAIL << "MAIL";
From: $params{from} ($params{from_name})
To: $params{to}
Subject: $params{subject}
Content-Type: text/html

$params{body}
MAIL
	close SENDMAIL;
	return $return;
}
1;