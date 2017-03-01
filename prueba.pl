#!/usr/bin/perl -w
use strict;
use Getopt::Long;
use CGI::Carp qw(fatalsToBrowser);
use LWP::UserAgent;
use HTTP::Request;

#campos a sustituir en la pagina web
my $query_mailto = '';
my $query_mailfrom = '';
my $query_mail = ''; 
my $url = "https://www.wikileaks.org/hackingteam/emails/";

#opciones 
GetOptions('t_mailto=s' => \$query_mailto, #string 
           't_mailfrom=s'   => \$query_mailfrom, #string
           't_mailbody=s' => \$query_mail) #string 
or die("type: perl prueba.pl\n -t_mailto [campo_texto]\n -t_mailfrom [campo_texto\n -t_mailbody [campo_texto]\n");

#conexión con la página web
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(POST => $url);
$req->content_type('application/x-www-form-urlencoded');

#sustitución de los campos
$req->content('q=' . $query_mail . '&' . 
			  'mfrom=' . $query_mailfrom . '&' . 
			  'mto=' . $query_mailto);

#solicitud de los datos a la página web
my $response = $ua->request($req);
my $content = $response->content(); #contenido de la respuesta

#impresión de los resultados
print "Content-type: text/html\n\n";
print $content;
