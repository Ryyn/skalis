#/usr/bin/perl

use strict;
use warnings;
use File::Data;
use Term::Prompt;

my $ascii ='
 _  _   ___   _      ___     _     ___   ____  
 ) |) / ) __( ) |    \   \   )_\   )_ _( /  _ \ 
 | ( (  | _)  | (__  | ) (  /( )\  _| |_ )  \' / 
 )_|)_\ )___( )____( /___/ )_/ \_()_____(|_()_\ 
';
print($ascii."\n\n");
print("Welcome to the Keldair setup wizard!\nPlease follow the instructions to ensure proper results.\n\n");

my $file = './etc/keldair.conf';

`touch $file`;

my $config = File::Data->new($file);

$config->prepend('# Generated by Keldair setup script'."\n");
$config->append('# Do not modify this config unless you know what you\'re doing!'."\n\n");
$config->append('server {'."\n");

my $host = prompt('x', 'What is the hostname of the IRC server?', 'Where are you connecting', 'irc.example.tld' );
my $port = prompt('n', 'What port should Keldair connect to?', '', '6667' );

$config->append('    host = '.$host."\n");
$config->append('    port = '.$port."\n");
$config->append('}'."\n\n");

my $nick = prompt('x', 'What nick should the bot use?', 'Nickname', 'Keldair' );
my $ident = prompt('a', 'What should be the bot\'s ident?', 'nick!<this stuff here>@host', 'keldair' );
my $real = prompt('x', 'What should be the bot\'s real name?', '', 'Keldair IRC Bot' );

$config->append('keldair {'."\n");
$config->append('    nick = '.$nick."\n");
$config->append('    ident = '.$ident."\n");
$config->append('    real = "'.$ident.'"'."\n");
$config->append('}'."\n\n");

my $debug = prompt('x', 'Where should Keldair spit out debug information?', 'You could use a nick here as well', '#debug' );
my $general = prompt('x', 'What channels should Keldair join?', 'You can specify multiple by seperating them with a comma (#one,#two,#three)', '#keldair' );

