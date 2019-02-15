use strict;
use warnings;
use DBI;
use IO::Select;

$| = 1;

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

$dbh->do("LISTEN foo");

my $fd = $dbh->func("getfd");
my $sel = IO::Select->new($fd);

while (1) {
    print "waiting...";
    $sel->can_read;
    my $notify = $dbh->func("pg_notifies");
    if ($notify) {
        my ($relname, $pid) = @$notify;
        my $row = $dbh->selectrow_hashref("SELECT now()");
        print "$relname from PID $pid at $row->{now}\n";
    }
}


$sth -> finish();
$dbh -> disconnect();