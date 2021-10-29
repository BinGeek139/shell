$user_path = "C:\Users\" + $env:UserName + "\Desktop"
Set-Location $user_path


#set up my .csv output file with column headers
Write-Output ("Date,Time,Priority,Classification,Description,Source IP,Destination IP") | Out-File "alert_data.csv" -encoding ascii

#read the pcap file, extract data, write to my .csv output file
$file = ".\fast_short.pcap"
foreach ($line in Get-Content $file  )
{
    $split1 = $line.Split("[**]") 
    $date_time = $split1[0]           #date/time
    $attack_date = ($date_time.substring(0,5))  #date
    $attack_time = $date_time.Substring(6,5)
    $description = $split1[6].Trim(" ")
    $classification =  $split1[11].Substring(16)
    $priority = $split1[13].Substring(10,1)
    $iparray = $split1[14].trim(" ")
    $iparray = $iparray.Split(" -> ")
    $sourceip = $iparray[1]
    $destip = $iparray[5]


    Write-output (
    $attack_date + "," +
    $attack_time + "," +
    $priority + "," +
    $classification + "," +
    $description + "," +
    $sourceip + "," +
    $destip) | Out-File "alert_data.csv" -encoding ascii -Append
}

read-host "Processing is done.  Press enter to close the script"