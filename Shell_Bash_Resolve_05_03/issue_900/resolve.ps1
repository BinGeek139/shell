$MY_NAME="Jim Burkman"
$firt_name= $MY_NAME.Split(" ")[0]
$last_name= $MY_NAME.Split(" ")[1]
$user_path = "C:\Users\" + $env:UserName + "\Desktop"
Set-Location $user_path
$path= $user_path +"\" +$last_name
if(!(Test-Path $path)) {
    New-Item -Path $user_path -ItemType Directory -Name $last_name 
}

$file_data= $user_path + "\alert_full_short.zip"

if(Test-Path $file_data ) {
    Write-Host $file_data
    Expand-Archive -Path $file_data -DestinationPath $path -Force
}
else
{
    Write-Host "Please put the file alert_full_short.zip to Desktop"
    Exit 1
}

function option_1{
	$file_input=$path + "\alert_full_short.pcap"
   foreach($line in Get-Content $file_input)

    {
        Write-Host $line    
        $description= $line.Split("]")[2].Split("[")[0].Trim()
        Write-Host $description
    }
	
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
   option_1
}
elseif ($user_menu_choice -eq 2)
{
    Write-Host "option2"
}
elseif ($user_menu_choice -eq 3)
{
    Write-Host "option3"
}
elseif ($user_menu_choice -eq 4)
{
    clear
    break
}
else
{
    clear
    read-host "That is not a valid selection.  Press Enter to continue"
}


}




