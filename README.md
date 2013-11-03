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
	
	produce ja print toimii kätevästi esim
	ssh ukko086.hpc.cs.helsinki.fi "ls > ~/koulujutut/linux-fun/Week1/sharedls.txt;cat ~/koulujutut/linux-fun/Week1/sharedls.txt"


