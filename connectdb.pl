use strict;
use warnings;
use DBI;

my $drv = "Pg";
my $db = "info";
my $host = "10.200.0.4";
my $dsn = "DBI:$drv:database=$db;host=$host";
my $user = "info_bckp_switch";
my $password = "ofra2000HaZA";

my $qry = ("SELECT ip FROM computers WHERE name='switch150'");

my $dbh = DBI -> connect ($dsn, $user, $password) or "Error connections: $!";

my $sth = $dbh -> prepare($qry);
my $rv = $sth -> execute();

if (!defined $rv) {
	print "When the error occurred '$qry' : " . $dbh -> errstr . "\n";
	exit(0);
    } else {
	print "OK!\n";
}


$sth -> finish();
$dbh -> disconnect();