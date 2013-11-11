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

