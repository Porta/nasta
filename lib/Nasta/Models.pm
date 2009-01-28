package Nasta::Models;

use lib 'Models';


my $dir = 'Models';
opendir(DIR, $dir);
my @files = grep(/\.pm$/,readdir(DIR));
closedir(DIR);

foreach my $file (@files) {
	$file =~ s/\.pm//;
	eval "use $file";
}


1;
