# display calendar .csv list
#
# fields are:
#
# awk -F"\"*,\"*" -f $fn_disp_title $fn_cal_list

# Setup once
BEGIN {

    total=0;
    disp_screen=1;
    screen_width=75;
    if ( disp_screen == 1 ) {
        print ""
        print "---------------------------------------------------------------------------"
        print "                       ZFÜFI CHALET Besucher Kalender                      "
        print "                   https://teamup.com/ ...                   "
        print "---------------------------------------------------------------------------"
        print ""
    }
}

# Line by line
{

}

###########################
# Run in the end
END {

}


###########################
# Helper functions

#invert text
function inverted(s) {
    s = sprintf("%s%s%s", "\033[7m", s, "\033[0m");
    d_screen_width = d_screen_width + 7;
    return s;
}

# center text
function centered(s, w) {
    if ( w~/^[0-9]+$/ ) {
        width=w;
    }
    else {
        width=screen_width;
    }
    z = width - length(s);
    y = int(z / 2);
    x = z - y;
    s_out = sprintf("%*s%s%*s", x, "", s, y, "");
  return s_out;
}
