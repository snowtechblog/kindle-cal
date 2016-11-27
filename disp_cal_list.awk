# display calendar .csv list
#
# fields are:
#
# awk -F"\"*,\"*" -f $fn_disp_cal_list $fn_cal_list

# Setup once
BEGIN {

    total=0;
    disp_screen=1;
    screen_width=76;
}

# Line by line
{
# read variable
DTSTART=$1;
DTEND=$2;
SUMMARY=$3;
CATEGORIES=$4;
LASTMODIFIED=$5;

# output to screen
if ( disp_screen == 1) {
    # reset screen_width
    d_screen_width = screen_width - 9;

    # mac
    #getstart = sprintf("date -j -f \"%%Y%%m%%d\" \"+%%a(%%d.%%b)\" %i", DTSTART)
    # kindle
    getstart = sprintf("date -D %%Y%%m%%d -d %i +%%a\"(%%d.%%b)\"",DTSTART);
    getstart | getline datestart
    close(getstart) # close pipe

    #getend = sprintf("date -j -f \"%%Y%%m%%d\" \"+%%a(%%d.%%b)\" %i", DTEND)
    getend = sprintf("date -D %%Y%%m%%d -d %i +%%a\"(%%d.%%b)\"",DTEND);
    getend | getline dateend
    close(getend) # close pipe

    # get length of datesection:
    length_date = length(sprintf("%s to %s: ", datestart, dateend));

    final = sprintf(" %s to %s: \"%s\"", inverted(datestart), dateend, substr(SUMMARY,0,d_screen_width-length_date-10));
    final = sprintf("%-"d_screen_width"s", final);
    printf "%s (%s) \n", final, substr(CATEGORIES,0,4);
    final = ""

    total = total+1;

}
}

###########################
# Run in the end
END {
    if ( disp_screen == 1 ) {
        print "\n -------------------"
        print " Number of entries = "total"\n";
    }
}


###########################
# Helper functions

#invert text
function inverted(s) {
    s = sprintf("%s%s%s", "\033[7m", s, "\033[0m");
    d_screen_width = d_screen_width + 7;
    return s;
}


