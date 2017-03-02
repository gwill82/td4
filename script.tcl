#Create a simulator object
set ns [new Simulator]

proc wnd { src fid trfile} {
	global ns
	puts $trfile "[$ns now] $fid [$src set cwnd_]"
	$ns at [expr [$ns now]+0.01] "wnd $src $fid $trfile"
} 

set wndfile [open "wndfile.tr" w]
#Open the trace_simu file
set trace_simu [open "onetcp_tracefile.tr" w]
$ns trace-all $trace_simu

#Create nodes
for {set a 0} {$a < 6} {incr a} {
set n$a [$ns node]
}

Queue/DropTail set limit_ 50

#Create links between the nodes
$ns duplex-link $n0 $n2 10Mb 10ms DropTail
$ns simplex-link $n1 $n2 2Mb 10ms DropTail
$ns simplex-link $n2 $n3 2Mb 10ms DropTail
$ns simplex-link $n3 $n2 0.5Mb 100ms DropTail
$ns duplex-link $n3 $n4 10Mb 10ms DropTail
$ns simplex-link $n3 $n5 2Mb 10ms DropTail

#Setup a TCP connection
set tcp [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
$tcp set fid_ 0
$tcp set packetSize_ 1460
$tcp set window_ 1000000

set tcp2 [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n4 $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 1
$tcp2 set packetSize_ 1460
$tcp2 set window_ 1000000

#Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP

$ns at 5.0 "$ftp start"
$ns at 5.0 "wnd $tcp 0 $wndfile"
$ns at 30.0 "$ftp2 start"
$ns at 80.0 "$ftp stop"
$ns at 95.0 "$ftp2 stop"
$ns at 95.5 "$ns flush-trace"
$ns at 95.6 "close $trace_simu"
$ns at 100.0 "$ns halt"
$ns run







