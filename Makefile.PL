use inc::Module::Install;
use Module::Install::Repository;
use Module::Install::ReadmePodFromPod;
name 'Mojolicious-Plugin-Webtail';
all_from 'lib/Mojolicious/Plugin/Webtail.pm';
readme_pod_from 'lib/Mojolicious/Plugin/Webtail.pm';

# Windows(Win32) unsupported
die "$^O unsupported" if ( $^O eq 'MSWin32');

requires 'Mojolicious';

tests 't/*.t';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
