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



