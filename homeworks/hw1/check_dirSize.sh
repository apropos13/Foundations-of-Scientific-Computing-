#!/bin/bash                     
cmd='du * | sort -n -r| head -3'
bash -c "$cmd"
