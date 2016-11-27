#!/bin/sh

###########################
# prevent screensaver and set up kindle
###########################
lipc-set-prop com.lab126.powerd preventScreenSaver 1

###########################
# variables
###########################
dd_tmp="./data/";
dd_scripts="./"

fn_calender=$dd_tmp"temp_cal.ics";
fn_cal_list=$dd_tmp"list_cal.csv";
fn_read_ics_file=$dd_scripts"read_ics_file.awk"
fn_disp_cal_list=$dd_scripts"disp_cal_list.awk"
fn_disp_title=$dd_scripts"disp_title.awk"
fn_mini_cal=$dd_scripts"mini_cal.awk"
fn_month1_temp=$dd_tmp"1.txt"
fn_month2_temp=$dd_tmp"2.txt"
fn_modify_cal=$dd_scripts"modify_cal.awk"

# Start never ending loop...
# -------------------------------
while [ 1 -eq 1 ]; do

    # prevent screensaver and set up kindle - every time ...
    lipc-set-prop com.lab126.powerd preventScreenSaver 1

    ###########################
    # get calender file
    if [ -f $fn_calender ]; then
        rm $fn_calender
    fi
    wget -O $fn_calender http://ics.teamup.com/feed/ ... /0.ics

    ###########################
    # read .ics icalender file and sort it
    awk -F":" -f $fn_read_ics_file $fn_calender | \
    sort -t ',' -k 1 > $fn_cal_list


    # sleep to see the scripts output
    echo "Sleeping 5 seconds ..."
    sleep 5

    clear

    awk -F"\"*,\"*" -f $fn_disp_title $fn_cal_list

    cat $dd_tmp$(date +%m%Y)".txt"
    echo ""

    ###########################
    # display calender list
    awk -F"\"*,\"*" -f $fn_disp_cal_list $fn_cal_list

    echo
    echo last updated:
    date

    ## DELAY: wait for 10 minutes
    sleep 120
done

