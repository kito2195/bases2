#!/usr/bin/perl -w
use strict;
use CGI::Carp qw(fatalsToBrowser);

use LWP::UserAgent;
use HTTP::Request;

#campos a sustituir en la pagina web
my $query_mailto = '';
my $query_mailfrom = '';
my $query_mail = ''; 

my $tipo_campo = $ARGV[0];
my $texto = $ARGV[1];

#conexión con la página web
my $ua = LWP::UserAgent->new;
$ua->agent("Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)");

my $req = HTTP::Request->new(POST => "https://www.wikileaks.org/hackingteam/emails/");
$req->content_type('application/x-www-form-urlencoded');
$req->content(query_mailfrom);

my $response = $ua->request($req);
my $content = $response->content(); #contenido de la respuesta

print "Content-type: text/html\n\n";
print $content;
