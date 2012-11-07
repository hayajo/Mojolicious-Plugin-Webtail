use Mojo::Base qw{ -strict };

use Mojo::IOLoop;
use Mojo::URL;

my $_servers = {};

sub get_server { $_servers->{$_[0]} || +{} }

sub start_server {
    my $app  = shift;
    my $args = { @_ };
    my $port = delete( $args->{port} ) || Mojo::IOLoop->generate_port;

    my $pid = open my $fh, '|-'; # fork
    $fh->autoflush;

    # parent
    if ($pid) {
        sleep 3;
        sleep 1 while !IO::Socket::INET->new(
            Proto    => 'tcp',
            PeerAddr => '127.0.0.1',
            PeerPort => $port,
        );
        my $url = Mojo::URL->new("http://127.0.0.1:$port");
        $_servers->{$pid} = { url => $url, fh => $fh };
        return (wantarray) ? ( $url, $pid ) : $url;
    }
    # child
    else {
        setpgrp or die "$!";
        my @args = ( 'daemon', '-l', "http://127.0.0.1:$port", @{ $args->{options} || [] } );
        # start server daemon
        open my $server, '|-', $^X, $app, @args;
        $server->autoflush;
        while (<>) { chomp; print $server $_ }
    }
}

sub stop_server {
    my @list_pid = ( @_ ) ? @_ : keys %$_servers;
    for my $pid ( @list_pid ) {
        unless ( kill 0, $pid ) {
            warn "already stopped: $pid";
            next;
        }
        kill -15, getpgrp $pid; # send SIGTERM to process-group of server daemon
        waitpid $pid, 0;
        delete $_servers->{$pid};
    }
}

1;
