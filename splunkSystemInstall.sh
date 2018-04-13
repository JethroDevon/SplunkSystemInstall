#!/bin/sh

        #------------------------------------------------------------#
                 WHAT=" =SPLUNK SYSTEM INSTALL SCRIPT= "
        L="----------------------------------------------------------"
        #                                                            #
        WHO="               Jethro Holcroft - ECS                    "
        WHEN="                     10-04-18                          "
        #                                                            #
        #                                                            #
        HOW="  SSH comands sent to remote servers to install a system,
        \n          forwarders indexers and search heads.            "
        #------------------------------------------------------------#


#COLOURS!
fgRed=$(tput setaf 1)     ; fgGreen=$(tput setaf 2)  ; fgBlue=$(tput setaf 4)
fgWhite=$(tput setaf 7)   ; fgBlack=$(tput setaf 0)


#PRINT INFO
echo "\n\n\n" $fgWhite
echo $L
echo "           " $fgGreen $WHAT $fgWhite
echo $L "\n"
echo "              " $WHO
echo "                      " $WHEN "\n\n"
echo $HOW
echo $L "\n\n"


#REQUEST SPLUNK LINKS FROM USER AND EXTRACT FILE NAMES 
echo $fgGreen "Input link for Splunk zip file" $fgWhite
read SPLUNKLINK
echo $fgGreen "Input link for SplunkForwarder zip file" $fgWhite
read SPLUNKFORLINK 
SPLUNKTAR=$(basename "$SPLUNKLINK")
SPLUNKFORTAR=$(basename "$SPLUNKFORLINK")

#VARIABLE ARRAYS WILL STORE EACH DATA ENTRY
ADDRESS=()
PORT=()
ISENTERPRISE=()

#ITORATOR INCREMENTS FOR EACH SERVER ADDED
SERVERS=1


#PROMPTS FOR DETAILS ON INSTALLING SPLUNK FORWARDER AND SPLUNK ENTERPRISE
while true; do

    #PROMPTS FOR INPUT - whole ssh xxx@yyy.xyz address for now
    echo $fgGreen "Add ssh address" $fgWhite
    read ADDRESS[$SERVERS]
    echo $fgGreen "Add server ssh port number" $fgWhite
    read PORT[$SERVERS]
    echo $fgGreen "Select F for forwarder or S for Splunk Enterprise F/f/S/s"
    echo $fgWhite
    read ISENTERPRISE[$SERVERS]
    
    #EXIT ADDING SERVERS CONDITIONS
    echo $fgGreen "Finished Adding Data? Y/y/N/n" $fgWhite
    read EXIT
    if [ "$EXIT" = "Y" ] || [ "$EXIT" = y ]
    then
       break
    fi

    #INCREMENT ITERATOR 
    let "SERVERS++"
done


#DISPLAYS INPUT AND ASKS USER TO COMMIT TO INSTALL OF SYSTEM
echo "\n-------------------------------------------------"
echo $fgGreen "        Please Check and Select Install   " $fgWhite
echo  "------------------------------------------------- "
for (( i = 0; i <= $SERVERS; i++ )); do

    echo "${PORT[$i]} ${ADDRESS[$i]} ${ISENTERPRISE[$i]}"
done

echo "-------------------------------------------------" $fgRed
echo "SELECT Y/y TO GO AHEAD AND ANYTHING ELSE TO RESTART" $fgWhite
read goahead
if [ "$goahead" = Y ] || [ "$goahead" = y ]; then
    echo "Installing Splunk On Remote Computers"
    
   else
	exec "$ScriptLoc"
fi


#SSH INTO EACH BOX AND DOWNLOAD, UNZIP & INSTALL APPROPRIATE SPLUNK PROGRAM 
for (( i = 0; i <= $SERVERS; i++ )); do

    touch installspl.txt
    if [ "${ISENTERPRISE[$i]}" = S ] || [ "${ISENTERPRISE[$i]}" = s ]; then

	echo "wget $SPLUNKLINK" >> installspl.txt
	echo "tar -zxvf $SPLUNKTAR" >> installspl.txt
	echo "./splunk/bin/splunk start --accept-license" >> installspl.txt
	ssh -t -p "${PORT[$i]}" "${ADDRESS[$i]}" "bash -s" <./installspl.txt
    else
	
	echo "wget $SPLUNKFORLINK" >> installspl.txt
	echo "tar -zxvf $SPLUNKFORTAR" >> installspl.txt
	echo "./splunk/bin/splunk start --accept-license" >> installspl.txt
	ssh -t -p "${PORT[$i]}" "${ADDRESS[$i]}" "bash -s" <./installspl.txt
    fi
    rm installspl.txt
done







