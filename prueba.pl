#!/usr/bin/perl -w

use strict;
use Getopt::Long;
use CGI::Carp qw(fatalsToBrowser);
use LWP::UserAgent;
use HTTP::Request;
use HTML::TableExtract;


if(@ARGV == 2){
#campos a sustituir en la pagina web
my $mailto = ''; #aka 'mto=''
my $mailfrom = ''; #aka 'mfrom=
my $mailq = ''; #aka 'q='
my $url = "https://www.wikileaks.org/hackingteam/emails/";

#opciones 
GetOptions('t_mailto=s' => \$mailto, #string 
           't_mailfrom=s'   => \$mailfrom, #string
           't_mailbody=s' => \$mailq) #string 
or die("type: perl prueba.pl\n -t_mailto [campo_texto]\n -t_mailfrom [campo_texto\n -t_mailbody [campo_texto]\n");

#conexión con la página web
my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(POST => $url);
$req->content_type('application/x-www-form-urlencoded');

#sustitución de los campos
$req->content('q=' . $mailq . '&' . 
			  'mfrom=' . $mailfrom . '&' . 
			  'mto=' . $mailto);

#solicitud de los datos a la página web con los campos solicitados
my $response = $ua->request($req);

#contenido de la respuesta
my $content = $response->content();


my $table = HTML::TableExtract->new(headers => [qw(Doc # Date Suject From To)],);

$table->parse($content);

#Imprimir en terminal
foreach my $row($table->rows){
	print join("\t",@$row), "\n";
}

#impresión de los resultados
print ("Content-type: text/html\n\n");
#print $content;
}else{
	print("type: perl cliente.pl\n"); 
	print("options: \n");
	print(" -t_mailfrom [text]\n");
	print(" -t_mailto [text]\n");
	print(" -t_mailbody [text]\n");
}