#!/bin/bash

# 06/23/20
# Author: Blastomussa
# This script parses a csv of all accounts associated with an Azure AD tenant to
# find only the student accounts. Then it updates the csv fields associated
# with DisplayName and Department with the students new grade.The output is then
# saved to $HOME/Desktop/UpdatedStudentAccounts.csv
# Runs on MacOS and Linux distros

OUTPUTCSV="$HOME/Desktop/UpdatedStudentAccounts.csv"  #DEFAULT OUTFILE

usage(){
cat << EOF

Usage: UpdatedStudentAccounts.sh -i /path/to/csv

This script parses a csv populated with all accounts associated with an Azure AD
tenant finding only the student accounts. Then it updates the csv fields associated
with DisplayName and Department with the students new grade. The output is then
saved to $HOME/Desktop/UpdatedStudentAccounts.csv

OPTIONS:
  -i {path/to/csv}   ex. $HOME/Desktop/users.csv
  -h                 Show this message
EOF
}

check_arg(){
  if [ -z "$CSV" ] ; then
    printf "You must supply an input csv file...\n"
    usage
    exit 1
  fi

  if [ ! -f "$CSV" ]; then
    printf "The file $CSV does not exist...\n"
    usage
    exit 1
  fi
}

parse_csv(){
  awk '!/Guest/' $CSV \
    | awk '/Student/' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/12/, "13", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/12/, "13", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/11/, "12", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/11/, "12", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/10/, "11", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/10/, "11", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/09/, "10", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/09/, "10", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/08/, "09", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/08/, "09", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/07/, "08", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/07/, "08", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/06/, "07", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/06/, "07", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/05/, "06", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/05/, "06", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/04/, "05", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/04/, "05", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/03/, "04", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/03/, "04", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/02/, "03", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/02/, "03", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/01/, "02", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/01/, "02", $9)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/KG/, "01", $2)} 1' \
    | awk 'BEGIN{FS=OFS=","} {gsub(/KG/, "01", $9)} 1' \
    > $OUTPUTCSV
}

if [ $# -eq 0 ]; then
  printf "*** No arguments supplied ***\n"
  usage
  exit 1
fi

#flag Options
while getopts 'i:o:h' flag; do
  case "${flag}" in
    i)  CSV="${OPTARG}" ;;
    #o) OUTPUTCSV="${OPTARG}" ;;
    h)  usage
        exit 0 ;;
  esac
done

check_arg

parse_csv

exit 0
