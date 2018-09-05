#!/bin/sh
find /proc -regex '\/proc\/[0-9]+\/fd\/.*' -type l -lname "*$1*" -printf "%p -> %l\n" 2> /dev/null