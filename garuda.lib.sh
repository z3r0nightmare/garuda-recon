#!/bin/bash
greeting(){
 echo "hey this is garuda scipt for automating your bug bounty experience and scanning.What do you wish to accomplish?"
}
options(){
    echo -e "1.Quick scan for a domain  \n 2.Quick scan for a list of domains \n 3.Manual scanning with options \n 4.Only single utility use"
}
wildcard_filtering(){
 grep \*\..+\..+ ~/bug-bounty/programs/$DOMAIN_NAME/${DOMAIN_NAME}_scope
}
