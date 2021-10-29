MY_NAME='Jim burkman'
description_array=()
function option_1
{	
	input=alert_full_short.pcap
	echo "Please be patient. Parsing data..."
	if [ ! -f ./alert_full_short.pcap.tgz ];then
		echo "File alert_full_short.pcap.tgz not found. Please put file to current directory !"
		return  0
	fi
	
	tar -xf alert_full_short.pcap.tgz
	
	while IFS= read -r line
	do 
	descriptionTemp=$(echo $line | cut -d']' -f 3)
	description=$(echo $descriptionTemp | cut -d'[' -f 1)
	description=$(echo -e ${description} | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
	check=0
	for i in ${!description_array[*]};
		do
		name_g=$(echo ${description_array[$i]})
		if [[ $name_g == $description ]]; then
			check=1
			break
		fi
	done
	
	if [ $check -eq 0 ];
	then
		description_array+=("$description")
		
	fi
	
	
	
	
	
	IFS= read -r line
	
	priorityTemp=$(echo $line | cut -d':' -f 3)
	priority=$(echo $priorityTemp | cut -d']' -f 1)
	
	classificationTemp=$(echo $line | cut -d':' -f 2)
	classification=$(echo $classificationTemp | cut -d']' -f 1)
	
	IFS= read -r line
	
	dateInLine=$(echo $line | cut -d'-' -f 1)
	
	timeAndSourceTemp=$(echo $line | cut -d'-' -f 2)
	timeInLine=$(echo $timeAndSourceTemp | cut -d' ' -f 1)
	
	ipAndPortSource=$(echo $timeAndSourceTemp | cut -d' ' -f 2)
	ipSource=$(echo $ipAndPortSource | cut -d':' -f 1)
	portSource=$(echo $ipAndPortSource | cut -d':' -f 2)
	if [ $ipSource == $portSource ]
	then
	portSource='unspecified'
	fi
	
	destinationTemp=$(echo $line | cut -d'-' -f 3)
	destination=$(echo $destinationTemp | cut -d' ' -f 2)
	ipDestination=$(echo $destination | cut -d':' -f 1)
	portDestination=$(echo $destination | cut -d':' -f 2)
	if [ $ipDestination == $portDestination ]
	then
	portDestination='unspecified'
	fi
	
	IFS= read -r line
	packetType=$(echo $line | cut -d' ' -f 1)

	echo "$dateInLine,$timeInLine,$priority,$classification,$description,$packetType,$ipSource,$portSource,$ipDestination,$portDestination">> alert_full_short_cleaned.csv
	
	while IFS= read -r line;
	do 
	if [[ $line == "" ]]
	then 
	break
	fi
	done 
	done < $input


}


function option_2(){

header_arr=()
for i in ${!description_array[*]};
	do
	
	description_header=$(echo ${description_array[$i]})
	sumString=""
	declare -i i=1
	str=$(echo $description_header | cut -d' ' -f $i)
	strTranfer=$(echo $str | tr [:lower:] [:upper:])
	while [ $str == $strTranfer ]
	do
		if [ $i -eq 1 ]
		then
			sumString="$str"
		else
		
		sumString="$sumString $str"
		fi
		i=$i+1
		str=$(echo $description_header | cut -d' ' -f $i)
		strTranfer=$(echo $str | tr [:lower:] [:upper:])
		
	done
	majorDescriptors=$(echo $sumString | cut -d';' -f 2)
	majorDescriptors=$(echo $majorDescriptors | sed -e "s/ -//")
	check=0
	for i in ${!header_arr[*]};
		do
		name_f=$(echo ${header_arr[$i]})
		if [[ $name_f == $majorDescriptors ]]; then
			check=1
			break
		fi
	done
	
	if [ $check -eq 0 ];
	then
		header_arr+=("$majorDescriptors")
		
	fi
		
	done
	




while true ;
do
read -p "
Enter one or more starting characters for your major descriptor, or
Enter nothing to see all major descriptors, or
Enter 'exit' to return to the main menu: " first_begins_with
first_begins_with=$(echo $first_begins_with | tr [:lower:] [:upper:])
if [[ $first_begins_with == "EXIT" ]]
then
return 0
elif [[ $first_begins_with = "" ]]; then
for i in ${!header_arr[*]};
	do
		echo ${header_arr[$i]} | tr "," " "
	done
else
	arr_true=();
	for i in ${!header_arr[*]};
		do
		first_name=$(echo ${header_arr[$i]})
		if [[ $first_name = $first_begins_with* ]];then
			arr_true+=("${header_arr[$i]}")
		fi
	done
	if [ ${#arr_true[*]} -ne 0 ];
	then
		if [ ${#arr_true[*]} -ne 1 ]
		then 
			echo "More than one major descriptor matches.  Please try again."
			for i in ${!arr_true[*]};
			do
			name=$(echo ${arr_true[$i]})
			echo $name	
			done
		else
			name_a=$(echo ${arr_true[0]})
			match_arr=()
			echo "Your selection is $name_a"
			for i in ${!description_array[*]};
				do
				first_name=$(echo ${description_array[$i]})
				if [[ $first_name = $name_a* ]];then
					match_arr+=("$first_name")
				fi
			
			done
			
			echo "There are ${#match_arr[*]} unique results"
			read -p "Press Enter for a list of unique results: " abc
			
			for i in ${!match_arr[*]};
				do
				match_decription=$(echo ${match_arr[$i]})
				echo $match_decription
			
			done
						
		fi
	else
		echo "No major descriptor was found with those starting characters.  Please try again."
	fi

fi
done
}

function option_3()
{
input=alert_full_short_cleaned.csv
arr_classifications=()
declare -i i=0
while IFS= read -r line
	do 
	i=$i+1
	class=$(echo $line | cut -d',' -f 6)
	arr_classifications+=("$class")
	done < $input
declare -i count_tcp=0
declare -i count_udp=0
declare -i count_icmp=0
declare -i percent=100

for i in ${!arr_classifications[*]};
	do
		class_i=$(echo ${arr_classifications[$i]})
		if [ $class_i == "TCP" ]
			then
				count_tcp=$count_tcp+1
			elif [ $class_i == "UDP" ]; then
				count_udp=$count_udp+1
			else 
				if [ $class_i == "ICMP" ]
					then
					count_icmp=$count_icmp+1
					fi
			fi
	done

sum=$(($count_icmp + $count_udp + $count_tcp ))

echo "$sum instance(s) found in this file"
percent=$(( ($count_icmp + $count_udp + $count_tcp )* 100 / $i ))
if [ $percent -eq 0 ]
then
	echo  'Comprises less than .01% of all alerts'
else
	echo "Comprises $percent % of all alerts"
fi
echo "TCP: $count_tcp   UDP: $count_udp  ICMP: $count_icmp"
}

function option_4(){
first_name=$(echo $MY_NAME | cut -d' ' -f 1)
last_name=$(echo $MY_NAME | cut -d' ' -f 2)
file_name=$first_name"_"$last_name".tgz"
tar -cf $file_name alert_full_short_cleaned.csv  alert_full_short.pcap
exit 0
}


while true;
do
	echo "
----- MAIN MENU -----

Please select from the following options:

	1.  Parse alert data
	2.  Major descriptors
	3.  Classifications
	4.  Clean up and exit

"

read -p "Option #: " user_menu_choice

if [[ $user_menu_choice -eq 1 ]];then
	option_1
elif [[ $user_menu_choice -eq 2 ]];then
	option_2
elif [[ $user_menu_choice -eq 3 ]];then
	option_3
elif [[ $user_menu_choice -eq 4 ]];then
	option_4
elif [[ $user_menu_choice -eq 5 ]];then
	break
else
	echo "That is not a valid option.  Please try again."
	continue
fi
done 