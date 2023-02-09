use warnings;
use strict;

while (my$line = <>) {
	if ($line !~ /^#/) {
		print $line;
	}	
}



