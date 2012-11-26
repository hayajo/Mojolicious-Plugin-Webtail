use inc::Module::Install;
use Module::Install::Repository;
use Module::Install::ReadmePodFromPod;
name 'Mojolicious-Plugin-Webtail';
all_from 'lib/Mojolicious/Plugin/Webtail.pm';
readme_pod_from 'lib/Mojolicious/Plugin/Webtail.pm';

# Windows unsupported
die "$^O unsupported" if ( $^O eq 'MSWin32' || $^O eq 'cygwin' || $^O eq 'msys' );

requires 'Mojolicious';

install_script 'bin/mwtail';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
