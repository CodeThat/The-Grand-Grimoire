#!/usr/bin/perl

@tag=split(/-/,@ARGV[0]);
@ip1=split(/\ ./,@tag[0]);
@ip2=split(/\ ./,@tag[1]);

for($a=@ip1[0]; $a<1+@ip2[0]; $a++) {
        for ($b=@ip1[1]; $b<1+@ip2[1]; $b++) {
                for ($c=@ip1[2]; $c<1+@ip2[2]; $c++) {
                        for ($d=@ip1[3]; $d<1+@ip2[3]; $d++) {
                                $mwe = 'host $a.$b.$c.$d';
chop ($mwe);
chop ($mwe);

if (substr($mwe, 0, 4) ne "Host") {
        $mwe =~ s/.*pointer //g;
print "$a.$b.$c.$d = $mwe\ n";
                        }
                }
        }
}
}

