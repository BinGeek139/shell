import os,getpass, shutil, sys, zipfile

major_descriptors =('ATTACK-RESPONSES',
 'BAD-TRAFFIC', 'CHAT IRC', 'COMMUNITY WEB',
 'DNS SPOOF', 'ET ACTIVEX', 'ET CHAT IRC',
 'ET CNC', 'ET CURRENT_EVENTS', 'ET DNS',
 'ET EXPLOIT', 'ET INFO', 'ET MALWARE', 'ET P2P',
 'ET POLICY', 'ET SCAN', 'ET SHELLCODE', 'ET TROJAN',
 'ET USER_AGENTS', 'ET WEB_CLIENT', 'ET WEB_SERVER',
 'ET WEB_SPECIFIC_APPS', 'GPL', 'ICMP', 'INFO',
 'MS-SQL', 'MULTIMEDIA', 'P2P', 'POLICY', 'SCAN',
 'WEB-ATTACKS', 'WEB-CGI', 'WEB-CLIENT', 'WEB-FRONTPAGE',
 'WEB-IIS', 'WEB-MISC', 'WEB-PHP')

#parse alert data
def option_1():
    print('Please be patient.  Parsing data...')
    line_count = 0
    #create the good data file and add headers
    with open (os.path.join(my_dir, 'alert.full.maccdc2012_cleaned.csv'),'a') as storage:
        storage.write('Date,Time,Priority,Classification,Description,Packet Type,Source IP,Source Port,Destination IP,Destination Port\n')
    #make variables from raw data, write them back to clean file
    with open (os.path.join(my_dir,'alert.full.maccdc2012.pcap')) as data_file:
        for i in data_file:
            line_count += 1
            #pull the description from line 1 of an alert record
            if '[**]' in i:
                line1_split = i.split(']')
                description = line1_split[2][:-4].strip()
                description = description.replace(',',';')
            #pull the classification from line 2 of an alert record                    
            elif 'Classification' in i:
                line2_split = i.split(']')
                classification = line2_split[0].strip(' [')[16:]
                priority = line2_split[1].strip()[-1]
            #pull the date, time, ip address and ports from line 3 of an alert record
            #requiring -> and / prevents picking up the ORIGINAL DATAGRAM DUMP ip address line
            elif '->' in i and '/' in i:
                line3_split = i.split(' ')
                alert_date =line3_split[0][:5]
                alert_time = line3_split[0][6:11]
                source_ip_with_port = line3_split[1].strip()
                #check for source ip ports, handle if they exist
                if ':' in source_ip_with_port:
                    source_ip = source_ip_with_port.split(':')[0]
                    source_port = source_ip_with_port.split(':')[1]
                else:
                    source_ip = source_ip_with_port
                    source_port = 'unspecified'
                destination_ip_with_port = line3_split[3].strip()
                #check for destination ip ports, handle if they exist                    
                if ':' in destination_ip_with_port:                        
                    destination_ip = destination_ip_with_port.split(':')[0]
                    destination_port = destination_ip_with_port.split(':')[1]
                else:
                    destination_ip = destination_ip_with_port
                    destination_port = 'unspecified'
            #pull the packet type from line 4 of an alert record     
            elif 'DgmLen:' in i:
                packet_type = i[:4].strip()
            #use the blank line between alert records to write data to file    
            elif i.startswith('\n'):
                with open (os.path.join(my_dir, 'alert.full.maccdc2012_cleaned.csv'),'a') as storage:
                    storage.write(alert_date + ','
                                  + alert_time + ','
                                  + priority + ','
                                  + classification + ','
                                  + description + ','
                                  + packet_type + ','
                                  + source_ip + ','
                                  + source_port + ','
                                  + destination_ip + ','
                                  + destination_port + '\n')
            else:
                continue

#major descriptors
def option_2():
    description_matches_found = []
    if not os.path.isfile(os.path.join(my_dir,'alert.full.maccdc2012_cleaned.csv')):
        print('\nParse alert data first using choice 1 from the main menu.')
        return
    while True:
        tuple_matches = []
        print ('''
Enter one or more starting characters for your major descriptor, or
Enter nothing to see all major descriptors, or
Enter 'exit' to return to the main menu:  ''')
        user_choice = input('\nPlease enter your selection: ')
        user_choice = user_choice.upper()
        if user_choice == 'EXIT':
            break
        print()
        for i in major_descriptors:
            if i.startswith(user_choice):
                tuple_matches.append(i)
        if len(tuple_matches) == 0:
            print('\nNo major descriptor was found with those starting characters.  Please try again.')
            print()
            continue
        elif len(tuple_matches) == 1:
            print('Your selection is ' + tuple_matches[0])
            with open (os.path.join(my_dir, 'alert.full.maccdc2012_cleaned.csv'),'r') as good_data:
                for i in good_data:
                    line_split = i.split(',')
                    if line_split[4].startswith(tuple_matches[0]):
                        if line_split[4] not in description_matches_found:
                            description_matches_found.append(line_split[4])
            print('\nThere are ' + str(len(description_matches_found)) + ' unique results\n')
            input('Press Enter for a list of unique results: ')
            print()
            print(tuple_matches[0])
            print('-' * len(tuple_matches[0]))
            description_matches_found.sort()
            for m in description_matches_found:
                print(m)
            description_matches_found = []
        else:
            print('More than one major descriptor matches.  Please try again.')
            print()
            for j in tuple_matches:
                print(j)

#classifications
def option_3():
    file_line = 0
    unique_classifications=[]
    if not os.path.isfile(os.path.join(my_dir,'alert.full.maccdc2012_cleaned.csv')):
        print('\nParse alert data first using choice 1 from the main menu.')
        return
    with open (os.path.join(my_dir, 'alert.full.maccdc2012_cleaned.csv'),'r') as good_data:
        next(good_data)
        for i in good_data:
            file_line += 1
            line_split = i.split(',')
            new_classification = line_split[3]
            counter = 'not found'
            for i in unique_classifications:
                if new_classification == i[0]:
                    if line_split[5] == 'TCP':
                        i[1] += 1
                    elif line_split[5] == 'UDP':
                        i[2] += 1
                    elif line_split[5] == 'ICMP':
                        i[3] += 1
                    counter = 'found'
            if counter == 'not found':
                unique_classifications.append([new_classification])
                unique_classifications[-1] = unique_classifications[-1] + [0,0,0]
                if line_split[5] == 'TCP':
                    unique_classifications[-1][1] += 1
                elif line_split[5] == 'UDP':
                    unique_classifications[-1][2] += 1
                elif line_split[5] == 'ICMP':
                    unique_classifications[-1][3] += 1
    unique_classifications.sort()
    for a in unique_classifications:
        perc = (a[1]+a[2]+a[3])/file_line
        perc = int(perc*10000)
        perc = perc/100
        print()
        print(a[0])
        print('\t' + str(a[1]+a[2]+a[3]) + ' instance(s) found in this file')
        if perc == 0:
            print('\tComprises less than .01% of all alerts')
        else:
            print('\tComprises ' + str(perc) + '% of all alerts')
        print('\tTCP: ' + str(a[1]) + '  UDP: ' + str(a[2]) + '  ICMP: ' + str(a[3]))
        

#clean up and exit
def option_4():
    emp_data = zipfile.ZipFile(my_last_name + '_' + my_first_name + '.zip', 'w')
    os.chdir(my_dir)
    file_list = os.listdir()
    for i in file_list:
        emp_data.write(i, compress_type=zipfile.ZIP_DEFLATED)
    emp_data.close()
    os.chdir(the_desktop)
    shutil.rmtree(my_last_name)

#-------------------main code body-------------------

#name string
MY_NAME = 'Jim Burkman'
my_first_name = MY_NAME.split(' ')[0]
my_last_name = MY_NAME.split(' ')[1]
my_dir = os.path.join(my_last_name,my_first_name)

#make a path to the active desktop
the_desktop = os.path.join('C:\\Users\\Admin\\OneDrive - ptit.edu.vn\\Desktop')
os.chdir(the_desktop)

#delete and/or make student directory
if os.path.isdir(my_last_name):
    shutil.rmtree(my_last_name)
    os.makedirs(my_dir)
else:
    os.makedirs(my_dir)

#check for the zip file
if not os.path.isfile('alert.full.maccdc2012.zip'):
    print ('Please put alert.full.maccdc2012.zip on the desktop\
 then restart the script')
    input('\nPress Enter to exit the script')
    sys.exit()
else:
    unpacker = zipfile.ZipFile('alert.full.maccdc2012.zip')
    unpacker.extractall(path=my_dir)
    unpacker.close

#menu
while True:
    print ('''
----- MAIN MENU -----

Please select from the following options:

1.  Parse alert data
2.  Major descriptors
3.  Classifications
4.  Clean up and exit
''')

    user_menu_choice = input('Option#: ')

    if user_menu_choice == '1':
        option_1()
        continue
    elif user_menu_choice == '2':
        option_2()
        continue
    elif user_menu_choice == '3':
        option_3()
        continue        
    elif user_menu_choice == '4':
        option_4()
        break
    else:
        print('\nThat is not a valid option.  Please try again.')
        continue
