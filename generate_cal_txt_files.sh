

awk '{printf ("                %-21s |  ", $0); getline < "201612.txt"; print $0 }' 201611.txt > 112016.txt
awk '{printf ("                %-21s |  ", $0); getline < "201701.txt"; print $0 }' 201612.txt > 122016.txt
awk '{printf ("                %-21s |  ", $0); getline < "201702.txt"; print $0 }' 201701.txt > 012017.txt
awk '{printf ("                %-21s |  ", $0); getline < "201703.txt"; print $0 }' 201702.txt > 022017.txt
awk '{printf ("                %-21s |  ", $0); getline < "201704.txt"; print $0 }' 201703.txt > 032017.txt
awk '{printf ("                %-21s |  ", $0); getline < "201705.txt"; print $0 }' 201704.txt > 042017.txt
awk '{printf ("                %-21s |  ", $0); getline < "201706.txt"; print $0 }' 201705.txt > 052017.txt
awk '{printf ("                %-21s |  ", $0); getline < "201707.txt"; print $0 }' 201706.txt > 062017.txt

