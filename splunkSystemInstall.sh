#!/bin/sh


#-----------------------------------------------------------#
WHAT="          =SPLUNK SYSTEM INSTALL SCRIPT=              "
L="---------------------------------------------------------"
#                                                           #
WHO="            Jethro Holcroft - ECS                      "
WHEN="                  10-04-18                            "
#                                                           #
#                                                           #
HOW=" SSH comands sent to remote servers to install a system,
\n          forwarders indexers and search heads.           "
#-----------------------------------------------------------#


#COLOURS!
fgRed=$(tput setaf 1)     ; fgGreen=$(tput setaf 2)  ; fgBlue=$(tput setaf 4)
fgMagenta=$(tput setaf 5) ; fgYellow=$(tput setaf 3) ; fgCyan=$(tput setaf 6)
fgWhite=$(tput setaf 7)   ; fgBlack=$(tput setaf 0)


#INFO
echo "\n\n\n" $fgWhite $L
echo $fgGreen $WHAT
echo $fgWhite $L
echo $WHO
echo $WHEN
echo $HOW
echo $L "\n\n\n"


#COLLECT DATA
echo $fgGreen "Input link for Splunk zip file" $fgWhite
read SPLUNKLINK
echo $fgGreen "Input link for SplunkForwarder zip file" $fgWhite
read SPLUNKFORLINK
echo $fgGreen "Input temporary password to use" $fgWhite
read TPASS

#VARIABLE ARRAYS WILL STORE EACH
ADDRESS=()
PORT=()
ISENTERPRISE=()

#ITORATOR INCREMENTS FOR EACH SERVER ADDED
SERVERS=0

#PROMPTS FOR DETAILS ON INSTALLING SPLUNK FORWARDER AND SPLUNK ENTERPRISE
while true; do

    #PROMPTS FOR INPUT
    echo $fgGreen "Add server address" $fgWhite
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
    
#SSH INTO EACH SYSTEM AND INSTALL APPROPRIATE SPLUNK PROGRAM 

    
    #INSTALLS SPLUNKFORWARDER OR ENTEPRISE DEPENDING ON INPUT
    #if [ "$ISENTERPRISE" = F ] || [ "$ISENTERPRISE" = f ]
    #then
#	echo "Installing SplunkForwarder"
 #  
 #   elif [ "$ISENTERPRISE" = S ] || [ "$ISENTERPRISE" = s ]
 #   then
#	echo "Installing Splunk Enterprise"
 #   else
#	echo "oops - Try Again"
#	continue
 #   fi
     
