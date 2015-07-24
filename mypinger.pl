#!/use/bin/perl -w

#use strict;
#use warnings;
#use Net::Telnet;

#use Pg;
use DBI;

#$DB = Pg::connectdb("host=127.0.0.1 dbname=postgres user=info_bckp password=ofra2000HaZA");

$dbh = DBI -> connect("DBI:Pg:dbname=postgres host=127.0.0.1 user=info_bckp password=ofra2000HaZA");

$qry = ("SELECT ip FROM computers WHERE unit_id='76' ORDER BY ip");
#$qry = "SELECT ip FROM computers WHERE name='switch02'";

my $sth = $dbh -> prepare($qry);
my $rv = $sth -> execute();

#my $rv = $dbh -> do($qry);

while (@row = $sth -> fetchrow_array()){
	
	$ip = $row[0]; #get ip switch
#	print "$ip\n";
#	png();
	#$ping = system "ping -c 1 -q $ip";
	#print "$ping";
	#if ($print > 0) {print "$ip=yes\n";}
	#else {print "$ip=no\n";}
#}

#sub png {  
#	    my $ip = pop @ARGV;
	    $ping =  "ping -c 1 -q $ip";
	    @lines = `$ping`;
	    for $line (@lines)
	    {
		 if ($line =~ /\s+(\d+)% packet loss/)
		    {
			if ($1 eq '100')
			         { print "$ip - FAIL!\n";     
			         	$qry0 = ("UPDATE computers SET suffix='0' WHERE ip='$ip'");    
						my $rv = $dbh -> do($qry0);
#		         	 $qry = ("UPDATE computers SET suffix='1' WHERE ip='$ip;
#			         $DB -> exec($qry);
			         }	else
			         { print "$ip - OK!\n";
			         	$qry1 = ("UPDATE computers SET suffix='1' WHERE ip='$ip'");         
						my $rv = $dbh -> do($qry1)
#			         $qry = ("UPDATE computers SET suffix='0' WHERE ip='$ip'");
#			         $DB -> exec($qry);
			         }
	    	    }
}
}
$dbh -> disconnect();
#__END__

##modified 24.07.2013 by R$
