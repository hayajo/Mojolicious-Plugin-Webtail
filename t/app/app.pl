use Mojolicious::Lite;

use Getopt::Long;
my ($file, $webtailrc);
# my $file;
GetOptions(
    'file=s'      => \$file,
    'webtailrc=s' => \$webtailrc,
);

plugin 'Webtail', file => $file, webtailrc => $webtailrc;
# plugin 'Webtail', file => $file;

app->start;
