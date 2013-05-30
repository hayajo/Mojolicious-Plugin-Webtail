requires 'perl', '5.010001';

# requires 'Some::Module', 'VERSION';
requires 'Mojolicious', '>= 3.02';
requires 'Text::ParseWords', '0';

on test => sub {
    requires 'Test::More', '0.88';
};
