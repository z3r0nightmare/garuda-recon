#!/bin/bash

greeting(){
 echo "hey this is garuda scipt for automating your bug bounty experience and scanning.What do you wish to accomplish?"
}
options(){
    echo -e "1.Quick scan for a domain \n2.Quick scan for a list of domains \n3.Manual scanning with options \n4.Only single utility use"
    
}

wildcard_filtering(){
    
    cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_scope | grep "\*\..*\." | cut -d "." -f 2,3 > ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_wildcard_scope
    cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_scope | grep -v "\*\..*\." | cut -d "." -f 1,2> ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_non_wildcard_scope
    cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_non_wildcard_scope >  ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_all_domains_scope
    
    cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_non_wildcard_scope 
    echo 'non_wildcard'
    cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_wildcard_scope 
    echo 'wildcard'
    cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_all_domains_scope 
    echo 'all_domains_scope'


}
subdomain_enumeration(){
    subfinder -dL ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_wildcard_scope -o ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_subfinder_output
    firstrun=1

    for line in $(cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_wildcard_scope); do
     sublist3r -d $line -o ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_temp

     if [[ $firstrun == 1 ]]
        then     
            cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_temp > ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_sublist3r_output
        else 
            cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_temp >> ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_sublist3r_output
        fi
     firstrun=2

    done

    cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_subfinder_output > ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_temp
    cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_sublist3r_output >> ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_temp
    cat ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_temp | sort | uniq > ~/bug-bounty/programs/${DOMAIN}/${DOMAIN}_scope/${DOMAIN}_subdomains


}


