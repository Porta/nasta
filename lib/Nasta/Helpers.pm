package Nasta::Helpers;

use lib 'Helpers';


my $dir = 'Helpers';
opendir(DIR, $dir);
my @files = grep(/\.pm$/,readdir(DIR));
closedir(DIR);

foreach my $file (@files) {
	$file =~ s/\.pm//;
	eval "use $file";
}

1;
