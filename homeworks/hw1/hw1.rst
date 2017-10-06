.. _homework1:

Homework 1 (Due 6 pm, Friday, 10/13/2017)
##########################################################################

Please submit your homework (parts 5, 6, 7 and 8) to your git repo by
**6 pm, Friday, 10/13/2017**.
Although there is no need to commit any proofs of your work on parts 1 ~ 4,
you need to make sure you complete the assignments.

1. Please make either a Linux OS or Mac OS system available on your machine
   (see :ref:`ch01-platforms` and :ref:`ch01-installingLinuxOnPC`).

2. Please make sure you practice the basic Linux commands (see :ref:`ch01-unix-commands`)
   in the lecture
   note, as well as read and watch the recommended articles and visual tutorials.


3. There are a handful of Linux/Unix commands that are frequently used
   but haven't been covered in the lecture note. Some examples
   include: ``apropos``, ``awk``, ``diff``, ``chmod``, ``chown``,
   ``ln``, ``uniq``, etc. Study these commands using the Linux man page (e.g.,
   ``man apropos``) as well as reading/watching online resources
   (e.g., Google searches, youtube videos, etc.). Check what kinds of
   optional flags (i.e., letters followed by the minux sign, ``-`` on
   man pages) are available for each of those commands and try (at
   least some of) them.

   
4. Setup an account on BSOE and clone the course repo from the
   remote course repository on riverdance BSOE server to your local machine (see the sections
   in :ref:`ch01-git`).
   
5. Setup an account on Bitbucket to create your own repository hosted
   on Bitbucket. Follow the instructions below to practice creating a
   file and modify it:
   
   (a) Generate ``/homework`` and ``/homework/hw1`` directories on your
       local master branch and create/edit a file named ``bio.txt``
       under ``homework/hw1``.   This file includes the
       following information:
     
     * name, your major, email
     * shool year
     * research interests
     * advisor's name (if any)
     * experience in scientific computing:	 (1. a lot, 2. somewhat, 3. none)
     * experience in Linux/Unix (or Mac OS X): 	 (1. a lot, 2. somewhat, 3. none)
	
   (b) Check-in (or make a commit) ``bio.txt`` with some check-in
       comments such as:

       "my first check-in to my own repo on mm/dd/yy as part of homework 1".

   (c) After a successful check-in of ``bio.txt``, modify it by adding
       a new line on your OS and computer and your profile picture:

     * types of OS and machine for the class

   (d) Check-in the updated ``bio.txt`` to the repo again.

   (e) Check your commit history on your Bitbucket website account to
       see if the history show up correctly. Also use git commands
       (e.g., ``git status``, ``git log``, ``git log --graph``, etc.) to monitor your
       commit history. To see what kinds of options available for each
       git command, for example ``git log``, try ``git log --help`` to
       see various options.


6. Find ``roster.txt`` in the ``hw/hw1`` directory in the
   course repo you cloned from riverdance BSOE server.
   Check what kind of information the file has using proper linux
   commands. What you want is to extract information of
   the class members. When you do this, you are only allowed to 
   use combinations of linux commands to obtain what you want to know.

   Write a set of linux commands, all combined in one single line for
   each problem  using pipes, redirections, etc.) in order to do the
   following tasks, using ``roster.txt`` as an input file for all
   cases.
   In each, you need to provide a single line command and your output as your answer.

   (a) Produce a file ``roster_sort_firstName.txt`` that lists the
       class members in alphabetical order of their first names.

   (b) Produce a file ``roster_sort_lastName.txt`` that lists the
       class members in alphabetical order of their last names.

   (c) Produce a file ``roster_sort_lastName_noDuplicate.txt`` that
       removes all the duplicated names ignoring case differences
       (i.e., ``lee`` and ``Lee`` should be counted as same). Hint:
       use ``sort`` and ``uniq`` commands with options to ignore case sensitivity.
       
   (d) Count the number of enrolled students who are currently enrolled.

   (e) The names in the file you produced in (c) may look like::

	    BenezraLauren
	    CatelaniSierra
	    ChenJianhong
	    Dadgarparvin
	    .
	    .
	    .

       Produce a list of names with ``,`` and a space between the last and
       first names that looks like::

	   Benezra, Lauren
	   Catelani, Sierra
	   Chen, Jianhong
	   Dadgar, parvin
	    .
	    .
	    .	   

       Save your output to a file named ``roster_sort_lastNameSpace_noDuplicate.txt``. 
     
   (f) Count how many PhD students are enrolled in the class. Repeat
       the same to count MS and undergraduate students too.

   (g) Produce a list of SCAMMS students' last names only in reverse
       alphabetical order.


7. Include the following two tasks in your ``.bash_profile`` or ``.bashrc``:

   (a) Choose a directory location you most often visit (e.g.
       ``/Users/dongwook/Repos/ucsc/soe/teaching/2017-2018/Fall/AMS209/ams209Git/``).
       Add an ``export`` command to set a variable called ``MY_PATH``
       equal to the location of this directory  (see the `.bashrc`
       examples in :ref:`ch01-unix-commands`). Open a new terminal
       window and query the ``MY_PATH`` using::

	 $ echo $MY_PATH

       and try::

	 $ cd $MY_PATH

       Learn from this and see this is an easy way that can make
       navigating your files easier.

   (b) Include a new alias command for ``ls`` with an option
       either ``--color`` or ``-G`` whichever available on your
       system.
       You can name your new alias command little bit
       different from ``ls``, such as appending ``c`` at the end::

	 alias lsc='ls --color' (or alias lsc='ls -G')

       Open a new terminal window (or execute ``source ~./bashrc`` or
       ``source ~./bash_profile`` on the current terminal without
       needing to open a new windows), and see the difference between
       the standard command, ``ls``, and the new customized command, ``lsc``.
       
     
       

8. One day, you wonder if there is any convenient way to move ``N``
   levels of directories up from the current directory location while navigating
   Linux directory trees on your computer. After some internet search,
   you found one good  `approach <https://stackoverflow.com/questions/12198222/go-few-directories-up-in-linux>`_::

   Make alias in your ``.bash_profile`` or ``.bashrc``::
     
     
     function cd_up() {
     cd $(printf "%0.0s../" $(seq 1 $1));
     }
     alias 'cd..'='cd_up'

   and use::

     $ cd.. 3


   This little hack will make your move easier from one location down in the
   directory tree to another
   upper directory that has ``N`` levels between them. Otherwise, you
   need to do::

     $ cd ../../../

   
   Now you also want a little routine that only tells you the
   information on ``N`` levels upper directory location
   (i.e., the information equivalent to ``cd ../../../`` followed by
   ``pwd`` and ``ls``, in case with ``N=3``) *without* moving up the
   directory tree.
   Write a simple function routine called ``pwd_up()``, similar to
   ``cd_up()``, and include it in your ``.bash_profile`` with an
   alias::

     alias 'pwd..'='pwd_up'

