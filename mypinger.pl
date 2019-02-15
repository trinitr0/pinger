use strict;
use warnings;
use DBI;

my $qry = ("SELECT ip FROM computers WHERE name='switch150'");

my $dbh = DBI -> connect ("DBI:Pg:dbname=info user=info_bckp_switch host=10.0.0.4 password=ofra2000HaZA") or "Error connections: $!";
my $sth = $dbh -> prepare($qry);
my $rv = $sth -> execute();

if (!defined $rv)
{
  print "When the error occurred '$qry' : " . $dbh -> errstr . "\n";
    exit(0);
}

while (my @row = $sth -> fetchrow_array()){

my $ip = $row[0];
#my   $ip = pop @ARGV;
my   $ping =  "ping -c 1 -q $ip";
my   @lines = `$ping`;

     for my $line (@lines)
     {
         if ($line =~ /\s+(\d+)% packet loss/)
         {
            if ($1 eq '100')
           {
              print "$ip - FAIL!\n";
           }
           else
           {
              print "$ip - OK!\n";
           }
          }
         }
}
