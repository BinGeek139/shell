$name_list = @('Constance Castillo', 'Kerry Goodwin',
 'Dorothy Carson', 'Craig Williams', 'Daryl Guzman', 'Sherman Stewart',
 'Marvin Collier', 'Javier Wilkerson', 'Lena Olson', 'Claudia George',
 'Erik Elliott', 'Traci Peters', 'Jack Burke', 'Jody Turner',
 'Kristy Jenkins', 'Melissa Griffin', 'Shelia Ballard', 'Armando Weaver',
 'Elsie Fitzgerald', 'Ben Evans', 'Lucy Baker', 'Kerry Anderson',
 'Kendra Tran', 'Arnold Wells', 'Anita Aguilar', 'Earnest Reeves',
 'Irving Stone', 'Alice Moore', 'Leigh Parsons', 'Mandy Perez',
 'Rolando Paul', 'Delores Pierce', 'Zachary Webster', 'Eddie Ward',
 'Alvin Soto', 'Ross Welch', 'Tanya Padilla', 'Rachel Logan',
 'Angelica Richards', 'Shelley Lucas', 'Alison Porter', 'Lionel Buchanan',
 'Luis Norman', 'Milton Robinson', 'Ervin Bryant', 'Tabitha Reid',
 'Randal Graves', 'Calvin Murphy', 'Blanca Bell', 'Dean Walters',
 'Elias Klein', 'Madeline White', 'Marty Lewis', 'Beatrice Santiago',
 'Willis Tucker', 'Diane Lloyd', 'Al Harrison', 'Barbara Lawson',
 'Jamie Page', 'Conrad Reynolds', 'Darnell Goodman', 'Derrick Mckenzie',
 'Erika Miller', 'Tasha Todd', 'Aaron Nunez', 'Julio Gomez',
 'Tommie Hunter', 'Darlene Russell', 'Monica Abbott', 'Cassandra Vargas',
 'Gail Obrien', 'Doug Morales', 'Ian James', 'Jean Moran',
 'Carla Ross', 'Marjorie Hanson', 'Clark Sullivan', 'Rick Torres',
 'Byron Hardy', 'Ken Chandler', 'Brendan Carr', 'Richard Francis',
 'Tyler Mitchell', 'Edwin Stevens', 'Paul Santos', 'Jesus Griffith',
 'Maggie Maldonado', 'Isaac Allen', 'Vanessa Thompson', 'Jeremy Barton',
 'Joey Butler', 'Randy Holmes', 'Loretta Pittman', 'Essie Johnston',
 'Felix Weber', 'Gary Hawkins', 'Vivian Bowers', 'Dennis Jefferson',
 'Dale Arnold', 'Joseph Christensen', 'Billie Norton', 'Darla Pope',
 'Tommie Dixon', 'Toby Beck', 'Jodi Payne', 'Marjorie Lowe',
 'Fernando Ballard', 'Jesse Maldonado', 'Elsa Burke', 'Jeanne Vargas',
 'Alton Francis', 'Donald Mitchell', 'Dianna Perry', 'Kristi Stephens',
 'Virgil Goodwin', 'Edmund Newton', 'Luther Huff', 'Hannah Anderson',
 'Emmett Gill', 'Clayton Wallace', 'Tracy Mendez', 'Connie Reeves',
 'Jeanette Hansen', 'Carole Fox', 'Carmen Fowler', 'Alex Diaz',
 'Rick Waters', 'Willis Warren', 'Krista Ferguson', 'Debra Russell',
 'Ellis Christensen', 'Freda Johnston', 'Janis Carpenter', 'Rosemary Sherman',
 'Earnest Peters', 'Kelly West', 'Jorge Caldwell', 'Moses Norris',
 'Erica Riley', 'Ray Gordon', 'Abel Poole', 'Cary Boone',
 'Grant Gomez', 'Denise Chapman', 'Vernon Moran', 'Ben Walker',
 'Francis Benson', 'Andrea Sullivan', 'Wayne Rice', 'Jamie Mason',
 'Jane Figueroa', 'Pat Wade', 'Rudy Bates', 'Clyde Harris',
 'Andre Mathis', 'Carlton Oliver', 'Merle Lee', 'Amber Wright',
 'Russell Becker', 'Natalie Wheeler', 'Maryann Miller', 'Lucia Byrd',
 'Jenny Zimmerman', 'Kari Mccarthy', 'Jeannette Cain', 'Ian Walsh',
 'Herman Martin', 'Ginger Farmer', 'Catherine Williamson', 'Lorena Henderson',
 'Molly Watkins', 'Sherman Ford', 'Adam Gross', 'Alfred Padilla',
 'Dwayne Gibson', 'Shawn Hall', 'Anthony Rios', 'Kelly Thomas',
 'Allan Owens', 'Duane Malone', 'Chris George', 'Dana Holt',
 'Muriel Santiago', 'Shelley Osborne', 'Clinton Ross', 'Kelley Parsons',
 'Sophia Lewis', 'Sylvia Cooper', 'Regina Aguilar', 'Sheila Castillo',
 'Sheri Mcdonald', 'Lynn Hodges', 'Patrick Medina', 'Arlene Tate',
 'Minnie Weber', 'Geneva Pena', 'Byron Collier', 'Veronica Higgins',
 'Leo Roy', 'Nelson Lopez')


While($true)
{

Write-Host "Please select from following options:`n"
Write-Host "`t 1. List all names starting with one or more letters of the first name"
Write-Host "`t 2. List all names starting with one or more letters of the last name"
Write-Host "`t 3. Add a name"
Write-Host "`t 4. Delete a name"
Write-Host "`t 5. Exit`n"
$option= Read-Host "Option#" 

try
{
   $option -eq $option/1 | Out-Null
 }
catch
{
   clear
   continue
}
	
clear
 if (($option/1 -is [int]) -and ($option -ne "")  -and ($option -gt 0) -and ($option -lt 6 ))
 {
	if( $option -eq 1 )
	{
		$firstName=Read-Host  "Enter the first name, or a partial start of the first name"
		if( $firstName -eq ""){
			foreach ($i in $name_list)
			{
				Write-Host "$i"
			}
			
		}
		else
		{
			$j=0
			foreach ($i in $name_list)
			{
				if( $i.ToLower().StartsWith($firstName.ToLower()))
				{
					Write-Host "$i"
					$j=$j+1
				}
			}
			if ($j -eq 0)
			{
				Write-Host "No first names were found starting with $firtName"
			}
		}
		Write-Host "Press Enter to return to the previous menu"
		Read-Host
		clear
		
	}
	elseif ( $option -eq 2)
	{
		$lastName=Read-Host  "Enter the last name, or a partial start of the last name"
		if( $lastName -eq ""){
			foreach ($i in $name_list)
			{
				Write-Host "$i"
			}
			
		}
		else
		{
			$j=0
			foreach ($i in $name_list)
			{
				$myArray = @()
				$myArray += $i.Split()
				
				$stringnCompare= $myArray[1]
				if( $stringnCompare.ToLower().StartsWith($lastName.ToLower()))
				{
					Write-Host "$i"
					$j=$j+1
				}
			}
			if ($j -eq 0)
			{
				Write-Host "No last names were found starting with $lastName"
			}
		}
		Write-Host "Press Enter to return to the previous menu"
		Read-Host
		clear

	}
	elseif ( $option -eq 3)
	{
		$first= Read-Host "Enter the new first name"
		$last= Read-Host "Enter the new last name"
		$fullName= $first + " " + $last
		$name_list+=$fullName
		clear
	}
	elseif ( $option -eq 4)
	{
		while($true)
		{
			clear
			$full= Read-Host "Enter the full name, "1" to view names or "Q" to quit"
			if ($full -eq "1" )
			{
				
				$firstName= Read-Host "Enter the first name, or a partial start of the first name"
				if( $firstName -eq ""){
					foreach ($i in $name_list)
					{
					Write-Host "$i"
					}
				
				}
				else
				{
					$j=0
					foreach ($i in $name_list)
					{
						if( $i.ToLower().StartsWith($firstName.ToLower()))
						{
							Write-Host "$i"
							$j=$j+1
						}
					}
					if ($j -eq 0)
					{
						Write-Host "No first names were found starting with $firtName"
					}
				}	
				Write-Host "Press Enter to return to the previous menu"
				Read-Host	
				clear
			}
			elseif ( $firtName -eq "Q" )
			{
				clear
				break
			}
			else
			{
				$tempArray=@()
				foreach ($element in $name_list)
				{
					if ( $element -ne $full)
					{
						$tempArray += $element
 					}
				}
				$name_list=$tempArray
				Write-Host "$full has been deleted"
				Write-Host "Press Enter to return to the previous menu"
				Read-Host
				clear
				break
				
			}
			
		}
		
	}
	elseif ( $option -eq 5)
	{
		break
	}
	else
	{
        clear
        continue	
	}

 } else
 {
	clear	
 }


}