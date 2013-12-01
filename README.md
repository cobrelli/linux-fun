linux-fun
=========

Week1

Output redirection
	ls ~ > koodailut/linux-fun/Week1/list-home-directory.txt
	tuloste löytyy week1 kansiosta

Man Pages
ls -latr  //listaa kaikki, myös . muokatuin ensimmäisenä reversenä (ei tarvii scroll niin 		  //paljoa)

Identity shift
	ls ~ > koodailut/linux-fun/Week1/list-home-directory2.txt

	näköjään olinkin jo maskannut output redirectin tehtävän ls 
	(alias ls="ls --color=auto"), ls -latr on myös annettu o:lle

	joten redirectattu ls -latr

Man of chrome
	man: command exited with status 3: aiheutti ongelmia, 
	korjautui: sudo aptitude install groff
	alias cman ="man --html=google-chrome $@"
	alias cman="man --html=google-chrome $@"

Permanent changes //tehty myös laitoksen koneille
	.bash_profilessa sekä alias o="ls -latr", että alias ls="ls --color=auto"

Remote shells with SSH

	ukko086.hpc.cs.helsinki.fi

	alias cman='man --html=google-chrome '
	alias ls='ls --color=auto'
	alias o='ls -latr'

Remote invocations with SSH
	ssh ukko086.hpc.cs.helsinki.fi "ls"

	tuloste erilainen, palauttaa kaikki jonossa ilman värejä

Private and public keys
	lisätty sekä kotikoneelle että shell -> ukko

What about the passwords?
	shellillä vaati: eval `ssh-agent -s`
	ennenku toimi ssh-add

	ssh -X ukko086.hpc.cs.helsinki.fi
	toimi ilman passphrase

	jostain syystä vaatii joka kerta uudestaan evalit ja ssh-addit, liittyyn ilmeisesti 		etäkäyttöön?
	joka ilmeisesti johtuu uuden agentin luomisesta joka login

Keyring
	toimii kotikoneella, etänä ei ssh:llä lähtenyt toimimaan

The right file, at the right time
	lisätty code snippetti .bashrc & .bash_profile. aliakset toimi myös .bash_aliaksista 		käsin

(Non-)logins
	ssh -X vito@shell.cs.helsinki.fi -t "ls"
	vs.
	ssh -X vito@shell.cs.helsinki.fi "ls"

	-t pakottaa pty allokaation ja kutsutaan bashrc eikä bash_profile

	tehtävään poistettu linkki aliaksiin bash_profilesta

Shared home directories

	ohessa output koko logista, vaati ssh agentin manuaalisen käynnistyksen (koska 		kotikone > shell.cs.helsinki.fi > ukko)

	ssh ukko086.hpc.cs.helsinki.fi

	Welcome to Ubuntu 12.04.3 LTS (GNU/Linux 3.2.0-43-generic x86_64)

	 * Documentation:  https://help.ubuntu.com/

	 * This is node ukko086 of CS Department\'s high performance cluster Ukko.
	 * For documentaiton see: 
	 * https://www.cs.helsinki.fi/en/compfac/high-performance-cluster-ukko

	 * Please remember to NOT STORE IMPORTANT DATA on local disk except temporarily.
	 * Please do not leave idle sessions open. Log off after completing your tasks
	   and cleaning up any temporary files.
   
	 * 11.10.2013: /cs/taatto filesystem had gotten full again. Please remove files
	 * you do not need and please do not use it for long time storage.
	Last login: Sun Nov  3 18:44:07 2013 from melkinpaasi.cs.helsinki.fi

	vito@ukko086:~$ 

	cat koulujutut/linux-fun/Week1/hostname.txt 
	melkinpaasi
	
	produce ja print toimii kätevästi esim:
	ssh ukko086.hpc.cs.helsinki.fi "ls > ~/koulujutut/linux-fun/Week1/sharedls.txt;cat ~/koulujutut/linux-fun/Week1/sharedls.txt"

enter rsync

	rsync --archive --stats ~tkt_cam/public_html/2011/10/30/ koulujutut/linux-fun/Week1/Sunday.2011.10.30/

	pelkällä rsyncillä --stats

	Number of files: 25
	Number of files transferred: 24
	Total file size: 11179311 bytes
	Total transferred file size: 11179311 bytes
	Literal data: 11179311 bytes
	Matched data: 0 bytes
	File list size: 467
	File list generation time: 0.006 seconds
	File list transfer time: 0.000 seconds
	Total bytes sent: 11182146
	Total bytes received: 471

	sent 11182146 bytes  received 471 bytes  4473046.80 bytes/sec
	total size is 11179311  speedup is 1.00

	2 rsync

	Number of files: 25
	Number of files transferred: 0
	Total file size: 11179311 bytes
	Total transferred file size: 0 bytes
	Literal data: 0 bytes
	Matched data: 0 bytes
	File list size: 467
	File list generation time: 0.006 seconds
	File list transfer time: 0.000 seconds
	Total bytes sent: 476
	Total bytes received: 12

	sent 476 bytes  received 12 bytes  976.00 bytes/sec
	total size is 11179311  speedup is 22908.42

	kumpikaan toiminnoista ei kerro mitään, tekevät vain hiljaa

	rsync cp:n jälkeen

	Number of files: 25
	Number of files transferred: 0
	Total file size: 11179311 bytes
	Total transferred file size: 0 bytes
	Literal data: 0 bytes
	Matched data: 0 bytes
	File list size: 467
	File list generation time: 0.001 seconds
	File list transfer time: 0.000 seconds
	Total bytes sent: 476
	Total bytes received: 12

	sent 476 bytes  received 12 bytes  976.00 bytes/sec
	total size is 11179311  speedup is 22908.42

Time and date
	date +%A.%d.%m.%Y

	Sunday.03.11.2013

Inserting date

	koodi ---
	
	#!/bin/bash

	echo "rsync --archive ~tkt_cam/public_html/`date +%Y/%m/%d` koulujutut/linux-fun/Week1/`date +%A.%d.%m.%Y`"

	--- koodi


	tuloste:

	rsync --archive ~tkt_cam/public_html/2013/11/03 koulujutut/linux-fun/Week1/Sunday.03.11.2013


tiedostolistaus
	siirretty kansioon Week1

==============================================================

Week 2

The three most important files

	ls /foObarR 2> ~/subdir/ls-unsuccessful.txt

	result with cat

	ls-unsuccessful.txt | pbcopy

	ls: cannot access /foObarR: No such file or directory

Two at once!

	ls /trolol/ 2> sim-ls-failed.txt . > sim-ls-succesfull.txt

	produces two files:

	1. sim-ls-failed.txt with contents:

		ls: /trolol/: No such file or directory

	2. sim-ls-succesfull with contents:

		.:
		jep.txt
		k.txt
		ls-unsuccessful.txt
		sim-ls-failed.txt
		sim-ls-succesfull.txt

Hey, what about stdin?

	if file is absent or - cat reads from standard input, you can also cat <<< lol

	wc with cat

	cat jep.txt | wc -l
	       3

Useless use of cat

	hopefully I wont abuse it much ;f
	>cat safety

Pipelines

	/bin/ls ~ | wc -l
	       9

	ls > numberOfFiles.txt

	ls | wc -l
		   6

    cat numberOfFiles.txt | wc -l
    	   6

    
    jep.txt
	k.txt
	ls-unsuccessful.txt
	numberOfFiles.txt
	sim-ls-failed.txt
	sim-ls-succesfull.txt

Filters

	ls ~ | grep 'e'

	Desktop
	Documents
	Movies
	Pictures

	ls ~ | grep 'e' | wc -l
	        4

Interlude: bash

	which bash
	/bin/bash

	count-homedir.sh

	#! /bin/bash
	ls ~ | wc -l

	output:
	        9

Some assembly required

	ls -R

	recursive ls

	phew.. done with crazy ass regex

	ls -R ~tkt_cam/public_html/ | grep '201[1-9]/1[1-2]\|201[2-9]/\|^20111[1-2]\|^201[2-9]'

Just the pics, ma'am

	ls -R ~tkt_cam/public_html/ | grep '.jpg'

Umm, how much is that?
	
	ls -R ~tkt_cam/public_html/ | grep '.jpg' | wc -l
	101949	

Remember the backticks

	ls -R ~tkt_cam/public_html/ | grep '2011'$(date +%m%d)'[0-9]\{4\}.jpg'

	wc -l gives 24, so its correct

The big brother of ls

	find ~ -type f
	normal files in root

Everybody together now

	find  ~tkt_cam/public_html/ -regextype posix-extended -regex '.*/2011'$(date +%m%d)'[0-9]{4}.jpg' | wc -l	

	output is: 24

Gregory and Julian

	date --date "last thursday last week"
	Thu Oct 31 00:00:00 EET 2013

Intro to variables

	BASH_ARGV -contains all parameters of current bash call stack

	BASH_VERSION -contains string with version of current bash instance

	HOSTNAME -name of the current host

Special shell variables

	#! /bin/bash
	echo "$@"

	./echoVariables.sh asd `ls`

	output: 
	asd sim-ls-succesfull.txt sim-ls-failed.txt numberOfFiles.txt ls-unsuccessful.txt ls-homedir.sh list-pics-with-date.sh list-all-pics.sh list-all-from-nov.sh k.txt jep.txt find-pic-number-by-current-month.sh echoVariables.sh count-pics.sh count-homedir.sh

Difference between bash and bash

	#! /bin/bash
	variable=test

	echo within first shell \(pid $$\): \$variable=$variable
	bash -c 'echo within second shell \(pid $$\) \$variable=$variable'

	output:
	within first shell (pid 4049): $variable=test
	within second shell (pid 4051) $variable=


Rare exports

	#! /bin/bash
	export variable=test

	echo within first shell \(pid $$\): \$variable=$variable
	bash -c 'echo within second shell \(pid $$\) \$variable=$variable'

	output:
	within first shell (pid 4069): $variable=test
	within second shell (pid 4071) $variable=test

Remote invocation

	#! /bin/bash

	hostname=$1
	command=$2

	#echo $hostname $command
	ssh $hostname $command



	output:

	./remote-invocation.sh vito@shell.cs.helsinki.fi "ls ~/koulujutut/linux-fun"

	README.md
	README.md~
	Week1
	Week2

==============================================================

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

	ssh -t vito@shell.cs.helsinki.fi 'ssh vito@ukko086.hpc.cs.helsinki.fi "bzip2 -dc temp/*"' > test.tar

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

==============================================================

Week 4


Longcat

	#!/bin/bash
	if [ $1 -gt 0 ];then
		head -10 shortcat.txt
		for (( i=1; i<=$1; i++ ))
		do
			sed -n 11p shortcat.txt
		done
		tail -8 shortcat.txt | head -7
		name=$(tail -1 shortcat.txt)
		if [ $1 -gt 1 ];then
			echo "${name/Shortcat./Longcat.}"
		else
			echo "$name"
		fi
	else
		echo Please check your parameters, should be ./longcat.sh number
		exit 1
	fi


Daily maximum

	#!/bin/bash
	hottest=0
	hottest_file=0
	for i in $@
	do
		for file in $(find "$i" -name '*hp-temps.txt')
		do
			temp=`cat $file | grep 'PROCESSOR_ZONE' | gsed -e 's/\ \+/,/g' -e 's/\//,/g' -e 's/C/,/g'| cut -d "," -f4`
			if [ "$hottest" -lt "$temp" ]; then
				hottest_file=$file
				hottest=$temp
			fi
		done
	done
	echo "$hottest_file $hottest °C"
	#end_of_script

	Output:
	lost24/monitor//2012.04.25/10:50/hp-temps.txt 54 °C

...in TSV format

	#!/bin/bash
	while read data;do
		echo "$data" | gsed -e 's/\/\+/\//g' | cut -d '/' -f3- | rev | cut -d ' ' -f2- | rev | gsed -e 's/\ /\  /g' -e 's/\//\ /g' | cut -d ' ' -f1,2,4-
	done

	./max-temp.sh lost24/monitor/2011.11.11/ | ./in-tsv-format.sh 

	Output:
	2011.11.11   24

Daily maximums redux

	#!/bin/bash
	dir=$(find lost24/ -type d -maxdepth 2 -mindepth 2)
	for d in $dir;do
		./max-temp.sh $d
	done

	./daily-maximums-redux.sh | ./in-tsv-format.sh

	Output:
	monitor 2012.03.17  38
	monitor 2012.03.18  42
	monitor 2012.03.19  39
	monitor 2012.03.20  41
	monitor 2012.03.21  43

Fast draws with GnuPlot

	graph in max-daily-temps.pdf

Winter is Coming

	#!/bin/bash
	coolest=9999
	coolest_file=0
	for i in $@
	do
		for file in $(find "$i" -name '*hp-temps.txt')
		do
			temp=`cat $file | grep 'PROCESSOR_ZONE' | gsed -e 's/\ \+/,/g' -e 's/\//,/g' -e 's/C/,/g'| cut -d "," -f4`
			if [ "$coolest" -gt "$temp" ]; then
				coolest_file=$file
				coolest=$temp
			fi
		done
	done
	echo "$coolest_file $coolest °C"

I didn't see that one coming

	graph in daily-temps.pdf

Onwards to getopts and switch

And that's a wrap

	#!/bin/bash
	cmd=""
	opts=""
	unset csv
	unset program
	unset dirname
	print_help() {
  		echo "\
		Usage: `basename $0` [-t] -c | -w -p dir
		Arguments:
        -t        output as tab-separated values
        -c        find the coldest temperature
        -w        find the warmest temperature
        -p dir    search all subdirs of dir"
	}
 
	while getopts ":htcwp:" opt; do
		case $opt in
			t)
				opts="./in-tsv-format-sed.sh"
				;;
			c)
				cmd="./min-temp-sed.sh"
				;;
			w)
				cmd="./max-temp-sed.sh"
				;;
			p)
				cmd="$cmd $OPTARG"
				;;
			\?)
				echo "Invalid option: -$OPTARG" >&2
				print_help
				exit 1
				;;
			esac
	done

	if [ $opts ];then
		$cmd | $opts
	else
		$cmd
	fi


	./find-max-or-min.sh -tcp lost24/monitor/
	2012.02.02 04:15  7

	./find-max-or-min.sh -twp lost24/monitor/
	2012.04.25 10:55  54

==============================================================

Week 5

Counting in your head

	#!/bin/bash
	i=0
	sum=0
	for param in $@
	do
		let "sum += param"
		let "i += 1"
	done

	echo "scale=2; $sum / $i" | bc

	output:

	./average.sh 2 3 4
	3.00
	./average.sh 2 3 3
	2.66
	./average.sh 2 3 3
	2.66
	./average.sh 1 6 9
	5.33

Gone in 60 seconds (aka lost24-monitor-recap-megafun)	
