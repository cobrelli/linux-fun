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
