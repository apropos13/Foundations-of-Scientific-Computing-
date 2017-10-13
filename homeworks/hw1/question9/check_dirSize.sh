#!/bin/bash                     
cmd1='du -d 1 | sort -nr | head -4 | tail -3 > out.txt'                                  cmd2='du -d 1 | sort -nr'  

bash -c "$cmd1"
bach -c "$cmd2"
