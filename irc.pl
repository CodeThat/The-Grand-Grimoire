#!/usr/bin/perl -w

use IO::Socket;
use strict;
use warnings;
 
fork;

my $server;
my $port;
my $nick;
my $user;
my $name;
my $chan;
my $fd;
my $in;
 
$server = "irc.tddirc.net";
$port = 6667;
$nick = "botop-test";
$user = "opnetsbot";
$name = "...";
$chan = "#test";
 
$fd = new IO::Socket::INET (PeerAddr => $server, PeerPort => $port, Proto => "tcp");
 
print $fd "NICK $nick\r\n";
print $fd "USER $user \"\" \"\" :$name\r\n";
print $fd "JOIN $chan\r\n";

while ($in = <$fd>) {
   if ($in =~ /^PING (:[^ ]+)$/i) {
       print $fd "PONG :$1\r\n";
   }
   if ($in =~ /^!test/i) {
      print $fd "PRIVMSG #hackerthreads :it works\r\n";
      print "It works!\r\n";
   }
}
