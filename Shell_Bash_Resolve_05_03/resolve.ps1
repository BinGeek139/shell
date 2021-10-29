$MY_NAME="Jim Burkman"
$major_descriptors=@("BAD-TRAFFIC","DNS SPOOF","ET CURRENT_EVENTS","ET DNS","ET INFO","ET MALWARE","ET POLICY","ET TROJAN","ET WEB_CLIENT","ICMP","INFO","SCAN","WEB-IIS")
$major_descriptors_detail=@()
$firt_name= $MY_NAME.Split(" ")[0]
$last_name= $MY_NAME.Split(" ")[1]
$user_path = "C:\Users\" + $env:UserName + "\Desktop"
Set-Location $user_path
$path= $user_path +"\" +$last_name
$sum=0
$classification_array=@()

if(!(Test-Path $path)) {
    New-Item -Path $user_path -ItemType Directory -Name $last_name 
}

$file_data= $user_path + "\alert_full_short.zip"

if(Test-Path $file_data ) {
    Expand-Archive -Path $file_data -DestinationPath $path -Force
}
else
{
    Write-Host "Please put the file alert_full_short.zip to Desktop"
    Exit 1
}
while ($true)
{
	clear
	Write-Host ("
===== MAIN MENU =====

Please select from the following options:

	1.  Parser alert data
	2.  Major descriptors
	3.  Classifications
	4.  Clean up and exit
")

$user_menu_choice = read-host "Option#" 

if ($user_menu_choice -eq 1)
{	
	clear
	Write-Host "Please be patient. Parsing data..."
	$file_input=$path + "\alert_full_short.pcap"
	$file_output=$path + "\alert_full_short_cleaned.csv"
	$content=Get-Content $file_input
	$i=0
	while( $i -lt $content.count){
		$line = $content[$i] 
		
		$description= $line.Split("]")[2].Split("[")[0].Trim()
		
		$check=$true
		foreach($detail_major in $major_descriptors_detail){
			if($description -eq $detail_major)
			{
				$check=$false
			}
		}
		if($check){
			$major_descriptors_detail+=$description
		}
		
		
		
		$i+=1 
		$line = $content[$i]
		
		$priority=$line.Split(":")[2].Split("]")[0].Trim()
		$classification=$line.Split(":")[1].Split("]")[0].Trim()
		
		
		
		
		$i+=1 
		$line = $content[$i]
		
		$dateInLine=$line.Split("-")[0]
		$timeInLine=$line.Split("-")[1].Split(" ")[0]

		$ipAndPortSource=$line.Split("-")[1].Split(" ")[1]
		$ipSource=$ipAndPortSource.Split(":")[0]
		
		$portSource=""
		if( $ipAndPortSource.Split(":").count -ge 2 ){
			$portSource=$ipAndPortSource.Split(":")[1]
		} else
		{
			$portSource="unspecified"
		}
		$destination=$line.Split("-")[2].Split(" ")[1]
		$ipDestination=$destination.Split(":")[0]
		$portDestination=""
		if( $destination.Split(":").count -ge 2 ){
			$portDestination=$destination.Split(":")[1]
		} else
		{
			$portDestination="unspecified"
		}
		
		$i+=1 
		$line = $content[$i]

		$packetType=$line.Split(" ")[0]
		
		$sum+=1
		$check=$true
		foreach($class in $classification_array){
			if($classification -eq $class[3])
			{
				$check=$false
				if ($packetType -eq "TCP")
				{
					$class[0]+=1
					break
					
				}
				elseif ($packetType -eq "UDP")
				{
					$class[1]+=1
					break
				}
				else
				{
					$class[2]+=1
					break

				}
			}
		}
		if($check -eq $true){
				if ($packetType -eq "TCP")
				{
					$classTemp=@()
					$classTemp+=1
					$classTemp+=0
					$classTemp+=0
					$classTemp+=$classification
					$classification_array+= ,$classTemp
				}
				elseif ($packetType -eq "UDP")
				{
					$classTemp=@()
					$classTemp+=0
					$classTemp+=1
					$classTemp+=0
					$classTemp+=$classification
					$classification_array+= ,$classTemp
					
				}
				else
				{
					$classTemp=@()
					$classTemp+=0
					$classTemp+=0
					$classTemp+=1
					$classTemp+=$classification
					$classification_array+= ,$classTemp
					
				}
		}
				
		Write-Output ( $dateInLine + "," + $timeInLine + "," + $priority + "," + $classification + "," + $description + "," + $packetType + "," + $ipSource + "," + $portSource + "," + $ipDestination + "," + $portDestination ) | Out-File $file_output -encoding ascii -Append
		
		while($true)
		{
			$i+=1 
			$line = $content[$i]
			if ($line -eq ""){
				break
			}
		}
		$i+=1 
	}
	clear
}
elseif ($user_menu_choice -eq 2)
{
	clear
    while($true){
		$first_begins_with=Read-Host ("
 Enter one or more starting characters for your major descriptor, or
 Enter nothing to see all major descriptors, or
 Enter 'exit' to return to the main menu ")
	$first_begins_with=$first_begins_with.ToUpper()
	clear
	if($first_begins_with -eq "EXIT"){
		break
	} 
	elseif( $first_begins_with -eq "" )
	{
		foreach( $i in $major_descriptors){
			Write-Host " $i"
		}
		Write-Host "More than one major descriptor matches. Press Enter try again"
		Read-Host
	}
	else{
		$temp=@()
		foreach( $desc in $major_descriptors){
			if($desc.StartsWith($first_begins_with)){
				$temp+=$desc
			}
		}
		
		if($temp.count -eq 0){
			Write-Host "No major descriptor was found with those starting characters.  Press Enter try again."
			Read-Host
			
		} 
		elseif (($temp.count -eq 1)){
			$description_find= $temp[0]
			$detail_result=@()
			foreach($detail in $major_descriptors_detail){
				if($detail.StartsWith($description_find)){
					$detail_result+=$detail
				}
			}
			Write-Host "Your selection is $description_find"
			$coutResult=$detail_result.count
			if($coutResult -eq 1){
				Write-Host "There are one unique results"
				Write-Host
				Write-Host "Press Enter for the results"
			} else{
				Write-Host "There are $coutResult unique results"
				Write-Host
				Write-Host "Press Enter for a list of unique results"
			}
			
			Read-Host
			Write-Host $description_find
			Write-Host "-------"
			foreach( $index in $detail_result){
				Write-Host $index
			}
			Read-Host
		} else{
			foreach( $index in $temp){
			Write-Host $index
			}
			Write-Host "More than one major descriptor matches. Press Enter try again"
			Read-Host
		}
	}
	clear
	}
}
elseif ($user_menu_choice -eq 3)
{

	foreach($class in $classification_array){
		Write-Host "  "$class[3]
		
		$sumInElement=$class[0] + $class[1] + $class[2]
		Write-Host "  	$sumInElement instance(s) found in this file"
		
		$scale= $sumInElement / $sum
		$scaleRound=[math]::Round($scale,4) *100
		
		Write-Host "  	Comprises $scaleRound% of all alerts"
		Write-Host "  	TCP: "$class[0]"	UDP: "$class[1]"	ICMP: "$class[2]
		Write-Host
		
	}
	Read-Host "Press Enter to the main menu"
}
elseif ($user_menu_choice -eq 4)
{
    clear
	$data_file=$path + "\" + "alert_full_short.pcap"
	$data_result=$path + "\" + "alert_full_short_cleaned.csv"
	$destination=$user_path + "\" + $last_name +"_"+ $firt_name +".zip"
	$myzip = @{
	Path = $data_file, $data_result
	CompressionLevel = "Fastest"
	DestinationPath = $destination
	}
	Compress-Archive @myzip
	Remove-Item $path -Force -Recurse
	break	
    
	
}
else
{
    clear
    read-host "That is not a valid selection.  Press Enter to continue"
}


}



