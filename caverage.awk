#!/bin/gawk -f
# take file of spreadsheet and calculate collumn average.
BEGIN	{
	ORS = ""
	discarded = 0
	gtotal = 0
	goodrecord = 0		# number of good records
	nrecord = 0
	}
NR == 1	{		# first record only
	nfields = NF	# set nfields to number of fields in the record (NF)
	}		# assume this should be the number of fields in the file
	{		# for each record
		nrecord += 1
		if ($0 ~ /[^0-9. \t]/ || NF < nfields)		# check each record to see if it contains
		{						# any characters that are not digits,
	    							# periods, spaces, or TABs, or missing fields
	    							# skip bad records
				discarded += 1
				printf "\nRecord %d skipped:\n\t", nrecord
				for (count = 1; count <= nfields; count++) # for bad records, loop through each field
				{
					print count, ": ", $count, " -- "
#printf "%-8s", $count
				}
				printf "\n"
	    		next					# ignore the rest of the commands for the 
		}						# current record if this is a bad record.
		else
		{
	    		goodrecord += 1
	    		for (count = 1; count <= nfields; count++)	# for good records, loop through each field
	    		{
					printf "%8.2f", $count > "caverage.out"	
	    		}
	    		print "\n" > "caverage.out"
		}
	}
END	{	# print summary after processing the last record
	    print "\n"

	    for (count = 1; count <= nfields; count++)
	    {
		print " =======" > "caverage.out"
	    }
	    print "\n" > "caverage.out"
	    for (count = 1; count <= nfields; count++)
	    {
		printf "%8.2f", sum[count] / goodrecord > "caverage.out"
	    }
	    print "\n\n  Total Records: " nrecord "  Good Records: " \
	          goodrecord "  Discarded Records: " discarded > "caverage.out"
	    print "\n  Grand Average " gtotal / (goodrecord * nfields) \
                  "\n" > "caverage.out"
	}
