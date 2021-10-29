#! /bin/bash


name_array=('Constance_Castillo' 'Kerry_Goodwin' 'Dorothy_Carson' 'Craig_Williams' 
'Daryl_Guzman' 'Sherman_Stewart' 'Marvin_Collier' 'Javier_Wilkerson' 'Lena_Olson' 
'Claudia_George' 'Erik_Elliott' 'Traci_Peters' 'Jack_Burke' 'Jody_Turner' 'Kristy_Jenkins' 
'Melissa_Griffin' 'Shelia_Ballard' 'Armando_Weaver' 'Elsie_Fitzgerald' 'Ben_Evans' 'Lucy_Baker' 
'Kerry_Anderson' 'Kendra_Tran' 'Arnold_Wells' 'Anita_Aguilar' 'Earnest_Reeves' 'Irving_Stone' 
'Alice_Moore' 'Leigh_Parsons' 'Mandy_Perez' 'Rolando_Paul' 'Delores_Pierce' 'Zachary_Webster' 
'Eddie_Ward' 'Alvin_Soto' 'Ross_Welch' 'Tanya_Padilla' 'Rachel_Logan' 'Angelica_Richards' 
'Shelley_Lucas' 'Alison_Porter' 'Lionel_Buchanan' 'Luis_Norman' 'Milton_Robinson' 'Ervin_Bryant' 
'Tabitha_Reid' 'Randal_Graves' 'Calvin_Murphy' 'Blanca_Bell' 'Dean_Walters' 'Elias_Klein' 
'Madeline_White' 'Marty_Lewis' 'Beatrice_Santiago' 'Willis_Tucker' 'Diane_Lloyd' 'Al_Harrison' 
'Barbara_Lawson' 'Jamie_Page' 'Conrad_Reynolds' 'Darnell_Goodman' 'Derrick_Mckenzie' 
'Erika_Miller' 'Tasha_Todd' 'Aaron_Nunez' 'Julio_Gomez' 'Tommie_Hunter' 'Darlene_Russell' 
'Monica_Abbott' 'Cassandra_Vargas' 'Gail_Obrien' 'Doug_Morales' 'Ian_James' 'Jean_Moran' 
'Carla_Ross' 'Marjorie_Hanson' 'Clark_Sullivan' 'Rick_Torres' 'Byron_Hardy' 'Ken_Chandler' 
'Brendan_Carr' 'Richard_Francis' 'Tyler_Mitchell' 'Edwin_Stevens' 'Paul_Santos' 
'Jesus_Griffith' 'Maggie_Maldonado' 'Isaac_Allen' 'Vanessa_Thompson' 'Jeremy_Barton' 
'Joey_Butler' 'Randy_Holmes' 'Loretta_Pittman' 'Essie_Johnston' 'Felix_Weber' 'Gary_Hawkins' 
'Vivian_Bowers' 'Dennis_Jefferson' 'Dale_Arnold' 'Joseph_Christensen' 'Billie_Norton' 
'Darla_Pope' 'Tommie_Dixon' 'Toby_Beck' 'Jodi_Payne' 'Marjorie_Lowe' 'Fernando_Ballard' 
'Jesse_Maldonado' 'Elsa_Burke' 'Jeanne_Vargas' 'Alton_Francis' 'Donald_Mitchell' 'Dianna_Perry' 
'Kristi_Stephens' 'Virgil_Goodwin' 'Edmund_Newton' 'Luther_Huff' 'Hannah_Anderson' 'Emmett_Gill' 
'Clayton_Wallace' 'Tracy_Mendez' 'Connie_Reeves' 'Jeanette_Hansen' 'Carole_Fox' 'Carmen_Fowler' 
'Alex_Diaz' 'Rick_Waters' 'Willis_Warren' 'Krista_Ferguson' 'Debra_Russell' 'Ellis_Christensen' 
'Freda_Johnston' 'Janis_Carpenter' 'Rosemary_Sherman' 'Earnest_Peters' 'Kelly_West' 
'Jorge_Caldwell' 'Moses_Norris' 'Erica_Riley' 'Ray_Gordon' 'Abel_Poole' 'Cary_Boone' 
'Grant_Gomez' 'Denise_Chapman' 'Vernon_Moran' 'Ben_Walker' 'Francis_Benson' 'Andrea_Sullivan' 
'Wayne_Rice' 'Jamie_Mason' 'Jane_Figueroa' 'Pat_Wade' 'Rudy_Bates' 'Clyde_Harris' 'Andre_Mathis' 
'Carlton_Oliver' 'Merle_Lee' 'Amber_Wright' 'Russell_Becker' 'Natalie_Wheeler' 'Maryann_Miller' 
'Lucia_Byrd' 'Jenny_Zimmerman' 'Kari_Mccarthy' 'Jeannette_Cain' 'Ian_Walsh' 'Herman_Martin' 
'Ginger_Farmer' 'Catherine_Williamson' 'Lorena_Henderson' 'Molly_Watkins' 'Sherman_Ford' 
'Adam_Gross' 'Alfred_Padilla' 'Dwayne_Gibson' 'Shawn_Hall' 'Anthony_Rios' 'Kelly_Thomas' 
'Allan_Owens' 'Duane_Malone' 'Chris_George' 'Dana_Holt' 'Muriel_Santiago' 'Shelley_Osborne' 
'Clinton_Ross' 'Kelley_Parsons' 'Sophia_Lewis' 'Sylvia_Cooper' 'Regina_Aguilar' 
'Sheila_Castillo' 'Sheri_Mcdonald' 'Lynn_Hodges' 'Patrick_Medina' 'Arlene_Tate' 'Minnie_Weber' 
'Geneva_Pena' 'Byron_Collier' 'Veronica_Higgins' 'Leo_Roy' 'Nelson_Lopez')

function option_1
{
	name_counter=0
	echo
	read -p "Enter the first name, or a partial start of the first name: " first_begins_with
	echo
	first_initial=$(echo ${first_begins_with:0:1} | tr [:lower:] [:upper:])
	first_remaining=$(echo ${first_begins_with:1} | tr [:upper:] [:lower:])
	first_begins_with="$first_initial$first_remaining"
	for i in ${!name_array[*]};
	do
		first_name=$(echo ${name_array[$i]} | cut -d "_" -f 1)
		if [[ $first_name = $first_begins_with* ]];then
			echo ${name_array[$i]} | tr "_" " "
			name_counter=1
		fi
	done
	if [[ $name_counter -eq 0 ]];then
		echo "No first name was found starting with $first_begins_with"
	fi
}

function option_2
{
	name_counter=0
	echo
	read -p "Enter the last name, or a partial start of the last name: " last_begins_with
	echo
	last_initial=$(echo ${last_begins_with:0:1} | tr [:lower:] [:upper:])
	last_remaining=$(echo ${last_begins_with:1} | tr [:upper:] [:lower:])
	last_begins_with="$last_initial$last_remaining"
	for i in ${!name_array[*]};
	do
		last_name=$(echo ${name_array[$i]} | cut -d "_" -f 2)
		if [[ $last_name = $last_begins_with* ]];then
			echo ${name_array[$i]} | tr "_" " "
			name_counter=1
		fi
	done
	if [[ $name_counter -eq 0 ]];then
		echo "No last name was found starting with $last_begins_with"
	fi
}


function option_3
{
while true;
do	
	read -p "Enter the new first name: " new_first_name
	if [[ $new_first_name == *" "* ]];then
		echo "Just the first name, please.  No spaces."
		continue
	fi
	read -p "Enter the new last name: " new_last_name
	first_initial=$(echo ${new_first_name:0:1} | tr [:lower:] [:upper:])
	first_remaining=$(echo ${new_first_name:1} | tr [:upper:] [:lower:])
	new_first_name="$first_initial$first_remaining"

	last_initial=$(echo ${new_last_name:0:1} | tr [:lower:] [:upper:])
	last_remaining=$(echo ${new_last_name:1} | tr [:upper:] [:lower:])
	new_last_name="$last_initial$last_remaining"
	new_name="$new_first_name $new_last_name"
	new_name=$(echo $new_name | tr " " "_")
	name_array+=("$new_name")
	echo
	echo "$new_name has been added" | tr "_" " "
	break
done
}

function option_4
{
while true;
do

	delete_counter=0
	echo
	echo "Delete a name by entering the full name ie: John Smith"
#	read -p "Enter Q to return to the main menu, 1 to view names, or enter the name:  " delete_name
	read -p "Enter the full name (Q to return to the main menu, 1 to search first names): " delete_name
	if [[ $delete_name == "Q" || $delete_name == "q" ]]; then
		break
	elif [[ $delete_name == "1" ]];then
		option_1
		continue
	fi
	delete_name=$(echo $delete_name | tr " " "_")
	delete_name=$(echo $delete_name | tr [:upper:] [:lower:])
	first_name=$(echo $delete_name | cut -d "_" -f 1)
	last_name=$(echo $delete_name | cut -d "_" -f 2)

	first_initial=$(echo ${first_name:0:1} | tr [:lower:] [:upper:] )
	first_remaining=$(echo ${first_name:1})
	first_name="$first_initial$first_remaining"

	last_initial=$(echo ${last_name:0:1} | tr [:lower:] [:upper:] )
	last_remaining=$(echo ${last_name:1})
	last_name="$last_initial$last_remaining"

	delete_name="$first_name $last_name"
	delete_name=$(echo $delete_name | tr " " "_")
	for i in ${!name_array[*]};
	do
		if [[ $delete_name = ${name_array[$i]} ]];then
			echo
			name_array=(${name_array[*]:0:$i} ${name_array[*]:$(($i+1))})
			echo "$delete_name has been deleted from the array" | tr "_" " "
			delete_counter=1
		fi
	done

	if [[ $delete_counter -ne 1 ]]; then
		echo "$delete_name was not found in the array." | tr "_" " "
	fi

done


}




while true;
do
	echo "
Please select from the following options:

	1.  List all names starting with one or more letters of the first name
	2.  List all names starting with one or more letters of the last name
	3.  Add a name
	4.  Delete a name
	5.  Exit
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
