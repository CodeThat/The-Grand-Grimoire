#!/usr/bin/perl
use IO::Socket;
sub fisher_yates_shuffle {
    my $array = shift;
    my $i;
    for ($i = @$array; --$i; ) {
        srand;
        my $j = int rand ($i+1);
        next if $i == $j;
        @$array[$i,$j] = @$array[$j,$i];
    }
}
my $sock = new IO::Socket::INET (PeerAddr => 'www.google.com',PeerPort => '80',Proto => 'tcp',TimeOut=>'0.9');
die "Could not create socket: $!\n" unless $sock;
print $sock "GET /search?hl=en&q=hotel&btnG=Google+Search HTTP/1.1\r\nAccept:*/*\r\nConnection:Close\r\n\n";

while($tin=<$sock>) {
$tinf=$tinf . $tin;
}

$tinf=~s/\n//gi;

$startsbs=0;
my @fullartin=();
my @fullartar=();
my @descriptionarray=();
$i=0;
while(substr($tinf,$startsbs,length($tinf))=~m/<p class=g><a class=l href="(.[^"]*)">(.{0,200})<\/a><table cellpadding=0 cellspacing=0 border=0><tr><td class=j><font size=-1>(.{0,500})<br><font color=#008000>/i) {


@fullartin[$i]=$1;
@fullartin[$i+1]=$2;
@fullartin[$i+2]=$3;

push @fullartar,[@fullartin];

$startsbs=index($tinf,"<td class=j><font size=-1>$3<br><font color=#008000>");

}
$i=0;
while($fullartar[$i][2]) {
$descriptionarray[$i]=$fullartar[$i][2];
$i++;
}
fisher_yates_shuffle(\@descriptionarray);
print $descriptionarray[0];

close($sock);
