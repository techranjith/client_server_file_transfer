set ns [new Simulator]

set n0 [$ns node]
set n1 [$ns node]

set nf [open out.nam w]
$ns namtrace-all $nf

set tf [open out.tr w]
$ns trace-all $tf

$ns duplex-link $n0 $n1 1Mb 10ms DropTail

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $n1 $sink0

$ns connect $tcp0 $sink0

proc finish {} {
	global ns nf tf
	$ns flush-trace 
	close $nf
	close $tf
	exec nam out.nam &
	exit 0
}

set ftp [new Application/FTP]
$ftp attach-agent $tcp0

$ns at 1.0 "$ftp start"
$ns at 4.0 "$ftp stop"

$ns at 5.0 "finish"

$ns run

