#!/usr/bin/env bash
#######!/bin/sh

# Parse the query string parameters
q0=${1}

declare -A querydict
while IFS== read key value
do
    querydict["$key"]="$value"
done < <(echo "$q0" | sed 's/&/\n/g' )

printf "${querydict[a]}\n"

#/usr/bin/perl -I/home/pi/SKAD/perl /home/pi/SKAD/perl/getNginxServerConfigs.pl
/usr/bin/perl -I/home/pi/SKAD/perl /home/pi/SKAD/perl/"${querydict[script]}.pl"
