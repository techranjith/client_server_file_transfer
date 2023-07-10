# Create a network
set ns [new Simulator]

# Create nodes
set server [$ns node]
set client [$ns node]

# Create links
$ns duplex-link $server $client 10Mb 10ms DropTail

# Set the queue size
$ns queue-limit $server $client 10

# Enable TCP
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $server $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $client $sink
$ns connect $tcp $sink

# Set file transfer parameters
set file_size 100  ;
set sending_rate 800 ;

# Generate file transfer traffic
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
$ftp set packetSize_ 1000
$ftp set interval_ 0.01
$ftp set fid_ 1
$ftp set rate_ $sending_rate
$ftp set number_ [expr $file_size/$sending_rate]
$ftp set random_ false

# Schedule simulation end time
$ns at 5.0 "$ns halt"

# Start simulation
$ns run

