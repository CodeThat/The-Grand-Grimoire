#!/usr/bin/perl

#TODO: Add much more options for tracing within one program.

print ("Enter the whois search term:\n");
chomp($domain = <STDIN>);
system whois -h whois.arin.net; 
