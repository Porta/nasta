package Users;
use base 'Jorge::ObjectCollection';

use User;

use strict;

sub create_object {
	return new User;
}

1;