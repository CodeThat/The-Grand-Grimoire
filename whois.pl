#!/usr/bin/perl

print ("Enter the whois search term:\n");
chomp($domain = <STDIN>);
system whois -h whois.arin.net; 
