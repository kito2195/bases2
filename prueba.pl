#!/usr/bin/perl -w
use strict;
use CGI::Carp qw(fatalsToBrowser);

use LWP::UserAgent;
use HTTP::Request;

my $query_mailto = ("mfrom" => '@gmail.com');
my $query_mailfrom = ('mfrom' => '@gmail.com');
my $query_mail = ('q' => '@gmail.com');

my $tipo_campo = $ARGV[0];
my $texto = $ARGV[1];

my $ua = LWP::UserAgent->new;
$ua->agent("Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)");

my $req = HTTP::Request->new(POST => "https://www.wikileaks.org/hackingteam/emails/");
$req->content_type('application/x-www-form-urlencoded');
$req->content(query_mailfrom);

my $response = $ua->request($req);
my $content = $response->content(); #contenido de la respuesta

print "Content-type: text/html\n\n";
print $content;
