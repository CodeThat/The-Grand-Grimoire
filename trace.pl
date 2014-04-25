#!/usr/bin/perl
@tag=split(/-/,@ARGV[0]);
@ip1=split(/\./,@tag[0]);
@ip2=split(/\./,@tag[1]);
for ($a=@ip1[0]; $a<1+@ip2[0]; $a++){
for ($b=@ip1[1]; $b<1+@ip2[1]; $b++){
for ($c=@ip1[2]; $c<1+@ip2[2]; $c++){
for ($d=@ip1[3]; $d<1+@ip2[3]; $d++){
print "$a.$b.$c.$d\n";
system "lynx -dump http://www.slac.stanford.edu/cgi-bin/nph-traceroute.pl?target=$a.$b.$c.$d &>trace_$a.$b.$c.$d &";}}}}
