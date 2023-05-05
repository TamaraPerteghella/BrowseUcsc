#!/bin/bash

case "$(uname -sr)" in

   Darwin*)
     echo 'Detected Mac OS X'
     for i in `cat $1`
     do 
         if [[ ${i:0:1} != "#" ]]; then      
            open $i 2> /dev/null &
            echo "Press a key to continue, or [q] to exit. "
            read var_name
            if [[ $var_name == "q" ]]; then
                exit 0
         fi;
         osascript shut_safari.sh
         else
             echo $i
         fi;
      done
     ;;

   Linux*)
     echo 'Detected OS: Linux'
     for i in `cat $1`
     do 
         if [[ ${i:0:1} != "#" ]]; then      
             firefox $i 2> /dev/null &
             echo "Press a key to continue, or [q] to exit. "
             read var_name
             if [[ $var_name == "q" ]]; then
                exit 0
             fi;
             wmctrl -a firefox; xdotool key Ctrl+w; wmctrl -r firefox -b add,shaded
         else
             echo $i
        fi;
     done
     ;;
esac
