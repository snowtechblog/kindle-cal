# read and format icalender file
#
# e.g. from
#   wget -O test.ics http://ics.teamup.com/feed/ ... /0.ics
#
# run awk script:
#   awk -F":" -f $fn_read_ics_file $fn_calender
# | \
#sort --field-separator=',' --key=1,2 > $fn_cal_list

# Setup once
BEGIN {
    OFS=":";

    total=0;
    disp_screen = 0;
    screen_width = 80;
}

# Line by line

# remove carriage return
$0 == sub(/\r/, "", $0);

# read variable
$1=="BEGIN"{EVENT=$2}
$1=="DTSTART;VALUE=DATE"{DTSTART=$2}
$1=="DTEND;VALUE=DATE"{DTEND=$2}
$1=="CREATED"{CREATED=$2}
$1=="LAST-MODIFIED"{LASTMODIFIED=$2}
$1=="SUMMARY"{SUMMARY=$2}
$1=="CATEGORIES"{CATEGORIES=$2}
$1=="END"{
    # detect events

    # output to file
    if ($2 == "VEVENT") {
        # d_start = DTSTART;
        # d_end = DTEND;
        # d_summary = SUMMARY;
        # d_cal = CATEGORIES;
        printf("%s,%s,\"%s\",\"%s\",%s\n", \
            DTSTART, DTEND, SUMMARY, CATEGORIES, LASTMODIFIED)
    }

    # output to screen
    #if ( disp_screen == 1 ) {
    if ($2 == "VEVENT" && disp_screen == 1) {
        # reset screen_width
        d_screen_width = screen_width - 7;

        #print DTSTART
        getstart = sprintf("date -j -f \"%%Y%%m%%d\" \"+%%a(%%d.%%b)\" %i", DTSTART)
        getstart | getline datestart
        close(getstart) # close pipe

        getend = sprintf("date -j -f \"%%Y%%m%%d\" \"+%%a(%%d.%%b)\" %i", DTEND)
        getend | getline dateend
        close(getend) # close pipe

        # get length of datesection:
        # BUG: if äüö linestr is one character longer than displayed
        length_date = length(sprintf("%s to %s: ", datestart, dateend));

        final = sprintf("%s to %s: \"%s\"", datestart, dateend, substr(SUMMARY,0,d_screen_width-length_date-10));
        final = sprintf("%-"d_screen_width"s", final);
        printf "%s (%s)\n", final, substr(CATEGORIES,0,4);
        final = ""

        # count them
        total=total+1;
        }
    } #}


# Run in the end
END {
    # sort the cal_list
}

# Helper functions


