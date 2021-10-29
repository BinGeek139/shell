#! /bin/sh

clear
echo "Processing the pcap file..."

#write the header to the file
header="Date,Time,Priority,Classification,Description,Source IP,Destination IP"
echo $header > alert_data.csv

#read lines from the pcap file
input="fast_short.pcap"
while IFS= read -r line
do
	date=${line:0:5}
	time=${line:6:5}
	priority=$(echo $line | cut -d "[" -f 6)
	priority=${priority:10:1}
	classification=$(echo $line | cut -d "[" -f 5)
	classification=${classification:16:-2}
	description=$(echo $line | cut -d "]" -f 3)
	description=${description:1:-4}
	line=$(echo $line | tr "}" "|")
	both_ip=$(echo $line | cut -d "|" -f 2)
	source_ip=$(echo $both_ip | cut -d ">" -f 1)
	source_ip=${source_ip:0:-2}
	destination_ip=$(echo $both_ip | cut -d ">" -f 2)
	destination_ip=${destination_ip:1}
	line_out="$date,$time,$priority,$classification,$description,$source_ip,$destination_ip"
	echo $line_out >> alert_data.csv
done < $input

clear
echo -e "The pcap file has been processed\n"
