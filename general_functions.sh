#!/bin/bash

## Count down and sleep for a second...

function count_down_and_sleep {

secs=$(($1))
while [ $secs -gt 0 ]; do
   echo -ne "Please wait $secs\033[0K seconds... \r"
   sleep 1
   : $((secs--))
done

}
