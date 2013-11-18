Week 3

Not glue but tar

	tar czf tar-test.tar.gz *.sh
	tar cjf tar-test.tar.bz2 *.sh
	tar cf tar-test-uncompressed.tar *.sh

	-rw-r--r--  1 cobu  staff    776 Nov 14 19:32 tar-test.tar.gz	
    -rw-r--r--  1 cobu  staff    824 Nov 14 19:38 tar-test.tar.bz2
    -rw-r--r--  1 cobu  staff  12288 Nov 14 19:38 tar-test-uncompressed.tar

    piped way to compress with tar

    tar cf - *.sh | gzip > test-tar-piped.tar.gz

Local and network file systems
	
	mbp
	/dev/disk0s2 on / (hfs, local, journaled)

Fetch and extract

	compressed version
	curl -O http://wiki.helsinki.fi/download/attachments/124126879/lost24-monitor-temps-and-fans-v2.tar.bz2

	uncompressed version (curled from site, pipelined and uncompressed)
	curl http://wiki.helsinki.fi/download/attachments/124126879/lost24-monitor-temps-and-fans-v2.tar.bz2 | bzip2 -d > lost-24-uncompressed.tar

	-rwxr--r--  1 cobu  staff  383088640 Nov 15 07:45 lost-24-uncompressed.tar

	deleted the file afterwards, kinda huge uncompressed

	AAAAAND incase i misunderstood i'll include way to pipeline with files
	curl http://wiki.helsinki.fi/download/attachments/124126879/lost24-monitor-temps-and-fans-v2.tar.bz2 | tar -xjvf -

No more disk space

	Finally managed to make it work. Using my mbp so I cant connect directly to ukko so I had to learn about nested ssh calls and then finally run the uncompress command with -dc option to direct output and then by > to direct where i wanted it.

	(the only problem I ran into was because passphrases, the ssh will wait for the passphase and as the output is directed it doesn't show it on the screen. I thought the passphrase query would remain in the test.tar file but it seems to only be included when there are errors, or then possibly bzip2 somehow overwrites it)

	ssh -t vito@shell.cs.helsinki.fi 'ssh vito@ukko086.hpc.cs.helsinki.fi "bzip2 -dc temp/*"' | tar -xvf -

    -rw-r--r--  1 cobu  staff  385955311 Nov 15 14:09 test.tar

    Was propably the hardest exercise so far.. (possibly because of my setup)

    ssh -t vito@shell.cs.helsinki.fi 'ssh vito@ukko086.hpc.cs.helsinki.fi "tar -xjOf temp/lost24-monitor-temps-and-fans-v2.tar.bz2"' > lol.lol

    now has propably? correctly outputs everything extracted and writes them to lol.lol file, but problem is now how to make them individual files?!

    propably something nasty because of the nested ssh... and passphrase query becoming the first thing in stdout

Ready, steady, go

	time ssh vito@ukko086.hpc.cs.helsinki.fi "bzip2 -dc temp/*" > test.tar

	real	0m25.176s
	user	0m9.753s
	sys	0m1.524s

	real	0m26.871s
	user	0m9.433s
	sys	0m1.608s

	real	0m27.316s
	user	0m9.313s
	sys	0m1.952s

	time curl http://wiki.helsinki.fi/download/attachments/124126879/lost24-monitor-temps-and-fans-v2.tar.bz2 | bzip2 -d > lost-24-uncompressed.tar

	real	0m20.501s
	user	0m14.229s
	sys	0m0.864s

	real	0m17.187s
	user	0m11.861s
	sys	0m0.844s

	real	0m25.852s
	user	0m20.565s
	sys	0m0.812s

The monitor data set

	whoa, lotsa stuff O.o
	974M	lost24/

grep and cut

	cat `find lost24/ -name hp-temps.txt | grep '2011.12.25'` | grep 'PROCESSOR_ZONE' | cut -c32-34 | sort | uniq

	22C
	23C
	24C
	25C
	26C
	27C
	28C
	29C
	30C
	31C

Don't run with scissors 

	cat `find lost24/ -name hp-temps.txt | grep '2011.12.25'` | grep 'PROCESSOR_ZONE' | gsed -e 's/\ \+/,/g' -e 's/\//,/g'

	#1,PROCESSOR_ZONE,31C,87F,62C,143F,

Too long, didn't read

	find lost24/ -name *hp-temps.txt -path */2011.11.*/* -exec grep 'PROCESSOR_ZONE' {} \;

	The output was huge..
	wc -l gave around 8640
	which sounds about right (12 times per hour*24 hours per day*30 days)

Escape to a true friend

	If *temps.txt is not escaped with '' shell will expand it when there is temps.txt in the current folder and search will fail

	find lost24/monitor/2011.12.25 -name *temps.txt
	find: temps.txt: unknown primary or operator

	find lost24/monitor/2011.12.25 -name '*temps.txt'
	lost24/monitor/2011.12.25/00:00/hp-temps.txt
	lost24/monitor/2011.12.25/00:05/hp-temps.txt
	lost24/monitor/2011.12.25/00:10/hp-temps.txt
	lost24/monitor/2011.12.25/00:15/hp-temps.txt
	...

Intro to loops


	#!/bin/bash
	for arg in "$@";
		do
			echo "$arg"
		done;

	f.ex
	./loop-test.sh 1 2

	output:
	1
	2

The Immelmann

	#!/bin/bash
	for file in $1/*; do
		inputfile=$file
		base=$(basename $inputfile)
		prefix=${base%.jpg}
		outputfile=test/$prefix-hipstah.jpg
		convert -sepia-tone 60% +polaroid $inputfile $outputfile
	done

    -rw-r--r--   1 cobu  staff  440950 Nov 17 23:30 201110300100-hipstah.jpg
    -rw-r--r--   1 cobu  staff  447427 Nov 17 23:30 201110300000-hipstah.jpg


Sidestep: testing

		if [ "$hottest" -lt "$temp" ]; then
			hottest_file=$file
			hottest=$temp
		fi

		didnt notice at first that reason of problems was no spaces between variables and []

Hottest day

	#!/bin/bash
	hottest=0
	hottest_file=0
	for file in $(find lost24/ -name *hp-temps.txt -path */2011.11.*/*)
	do
		temp=`cat $file | grep 'PROCESSOR_ZONE' | gsed -e 's/\ \+/,/g' -e 's/\//,/g' | cut -c19-20`
		if [ "$hottest" -lt "$temp" ]; then
			hottest_file=$file
			hottest=$temp
		fi
	done;

	echo "Hottest temp"
	echo "$hottest"
	echo "Found in"
	echo "$hottest_file"
	#End of Script

	output:
	Hottest temp
	29
	Found in
	lost24//monitor/2011.11.30/23:55/hp-temps.txt
