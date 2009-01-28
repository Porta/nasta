package Controllers::Account;
use base 'Nasta';
use Data::Dumper;

my $config = new Jorge::Config;

sub setup {
	my $self = shift;
	$self->routes([
		'/login' => 'login',
		'/user/login' => 'dologin',
		'/user/create' => 'create_user',
		'/user/edit' => 'edit_user',
		'/user/save_changes' => 'save_changes',
		'/user/activate/:md5' => 'activate_user',
		'/user/retrieve_password' => 'retrieve_password',
		'/user/register' => 'register',
        '/login' => 'login',
        '/logout' => 'logout',
	]);
}

sub login {
	my $self = shift;
	my $main_template = $self->load_tmpl("Views/main.htm");
	my $template = $self->load_tmpl("Views/login.htm");
	$main_template->param(base_url => $config->base_url);
	$main_template->param(content => $template->output);
    $self->param('debug', $self->session);
	return $main_template->output;
}

sub dologin {
	my $self = shift;
	my $q = $self->query;
	return $self->redirect("/") if $self->checkSession();

	my $email = $q->param('email');
	my $pass = $q->param('pass');

	my $user = User->new();
	my $logged_user = $user->checkmail(Email => $email);

	my $main_template = $self->load_tmpl("Views/main.htm");
	my $template = $self->load_tmpl("Views/login.htm");

	if ($logged_user){
	    if ($logged_user->Status->Description ne 'Confirmed'){
	    	$main_template->param(base_url => $config->base_url);
			$main_template->param(notifications => "Your account isn't confirmed yet");
			$main_template->param(js => JS->notify_error);
			$main_template->param(content => $template->output);
			return $main_template->output;
	    }
		if($logged_user->Pass eq $pass){
			$self->initSession($logged_user);
 			return $self->redirect("/");
		}else{
			$main_template->param(base_url => $config->base_url);
			$main_template->param(notifications => "You have typed a wrong password");
			$main_template->param(js => JS->notify_error);
			$main_template->param(content => $template->output);

			return $main_template->output;
		}
	}else{
		$main_template->param(notifications => "This email is not registered as a Adela member");
		$main_template->param(content => $template->output);

		return $main_template->output;
	}
}

sub create_user {
    my $self = shift;
    my $q = $self->query;
   # return "0|you are already registered" unless $self->checkSession();

    my $email = $q->param('email') || return "ERROR|wrong email";
    my $password = $q->param('pass') || return "ERROR|wrong password";

    my $user = User->new();
    unless ($user->checkmail(Email => $email)){
        $user->Email($email);
        $user->Pass($password);
        $user->insert;
        my $email_template = $self->load_tmpl('Views/Mails/Confirmation.htm');
        $email_template->param('link' => $config->base_url . '/user/activate/'.$user->Md5);
        my $response = Mailer->send(from => 'mail@adela.com', from_name =>'Adela', to => $user->Email, subject => 'Account Confirmation', body => $email_template->output);
        return "OK|Confirmation email sent";
    }else{
        return "ERROR|email already registered, type a new one";
    }
}

sub edit_user {
	my $self = shift;

	my $logged_user = $self->checkSession();
	return $self->redirect("/login") unless $logged_user;

	my $main_template = $self->load_tmpl("Views/main.htm");
	my $template = $self->load_tmpl("Views/account.htm");
	$template->param(email => $logged_user->Email);

	my $tabs = $self->load_tmpl("Views/tabs.htm");
	$tabs->param(account_tab => 1);
	$main_template->param(tabs => $tabs->output);

	$main_template->param(loggedin => $logged_user->Email);
	$main_template->param(base_url => $config->base_url);
	$main_template->param(content => $template->output);

	return $main_template->output;

}

sub save_changes {
	my $self = shift;
	my $q = $self->query;

	my $logged_user = $self->checkSession();
	return $self->redirect("/login") unless $logged_user;

	$logged_user->Email($q->param('email'));
	if ($q->param('pass')){
		$logged_user->Pass($q->param('pass'));
	}
	$logged_user->update;

	my $main_template = $self->load_tmpl("Views/main.htm");
	my $template = $self->load_tmpl("Views/account.htm");
	$template->param(email => $logged_user->Email);

	$main_template->param(loggedin => $logged_user->Email);
	$main_template->param(base_url => $config->base_url);
	$main_template->param(content => $template->output);
	$main_template->param(notifications => "Your changes has been saved");

	return $main_template->output;

}

sub activate_user{
	my $self = shift;
	my $q = $self->query;
	my $md5 = $q->param('md5');
		return $self->redirect('/') unless $md5;
	my $user = new User;
	$user->Md5($md5);
	$user->get_by('Md5');
		return $self->redirect('/') unless $user->Id;
		#return $self->redirect('/') unless $user->Status->Id == 0;
	$user->Status(Common->status('Confirmed'));
	$user->update;
	$self->initSession($user);
	return $self->redirect('/');
}

sub retrieve_password {
	my $self = shift;
	my $q = $self->query;

	my $email = $q->param('email') || return "That email is not an Adela member";

	my $user = User->new();
	my $logged_user = $user->checkmail(Email => $email);
	if ($logged_user){
		my $email_template = $self->load_tmpl('Views/Mails/Password_request.htm');
		$email_template->param(password => $logged_user->Pass);
		$email_template->param(base_url => $config->base_url);
		my $response = Mailer->send(from => 'mail@YOURAPPHERE.com', from_name =>'YOURAPPHERE', to => $logged_user->Email, subject => 'Password Request', body => $email_template->output);
		return "OK|An email with the password has been sent to " . $logged_user->Email;
	}else{
		return "ERROR|That email is not a member";
	}
}

sub register {
	my $self = shift;
	my $main_template = $self->load_tmpl("Views/main.htm");
	my $template = $self->load_tmpl("Views/register.htm");

	$main_template->param(base_url => $config->base_url);
	$main_template->param(content => $template->output);
	return $main_template->output;
}

sub logout{
    my $self = shift;
    $self->session->clear;
    return $self->redirect('/');
}

1;
