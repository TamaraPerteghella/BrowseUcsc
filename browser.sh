#!/bin/bash
index=1
size=$(wc -l $1)

case "$(uname -sr)" in
   # MAC OS
   Darwin*)
     echo 'Detected Mac OS X'
     open -a Safari && echo "Defaul Browser: Safari" || echo "No suitable browser find. Safari expected. Exit"; exit 0
     while $index < $size
     do 
         i=$(sed -n '($index)p' $1)
         if [[ ${i:0:1} != "#" ]]; then
             echo $(sed -n '($index-1)p' $1)
             open $i 2> /dev/null &
         else
             echo $i
             open $(sed -n '($index+1)p' $1) 2> /dev/null &
         fi;
         echo "Press enter to continue, a number to access the coordinates, or [q] to exit. "
         read var_name
         osascript shut_safari.sh
         while [ ($var_name < 0 || $var_name > $size) || $var_name != "q" || $var_name != "" ]
         do
             echo "Input not handled. Check that it respects the following criteria;
                   \> Insert a suitable position; boundaries [1, $size].\n Check with `grep -n` the index of the coordinates you are interested in.
                   \> Press enter to continue to the next coordinate.
                   \> Press `q` to exit."
         done
         ;;        
         if [[ $var_name == "q" ]]; then
             exit 0
         elif [[ $var_name == "" ]]; then
             index=$index+2
         else
             index=$var_name
         fi;
     done
     ;;

   # LINUX OS
   Linux*)
     echo 'Detected OS: Linux'
     #Check if at least one suitable program is available
     if [[ ( ! command -v firefox &> /dev/null ) && ( ! command -v google-chrome &> /dev/null ) ]]; then
         echo "No suitable program found; check the installation of Firefox and/or Chrome"
         exit 0
     fi;
     
     #Select the tool to open the browser
     if [[ ! command -v firefox &> /dev/null ]]; then
         browser=firefox
     else
         browser=google-chrome
     fi;
     
     while $index < $size
     do 
         i=$(sed -n $index $1)
         if [[ ${i:0:1} != "#" ]]; then
             echo $(sed -n $index-1 $1)
             $browser $i 2> /dev/null &
         else
             echo $i
             $browser $(sed -n $index+1 $1) 2> /dev/null &
         fi;
             
         echo "Press enter to continue, a number to access the coordinates, or [q] to exit. "
         read var_name
         wmctrl -a firefox; xdotool key Ctrl+w; wmctrl -r firefox -b add,shaded
         while [ ($var_name < 0 || $var_name > $size) || $var_name != "q" || $var_name != "" ]
         do
             echo "Input not handled. Check that it respects the following criteria;
                   \> Insert a suitable position; boundaries [1, $size].\n Check with `grep -n` the index of the coordinates you are interested in.
                   \> Press enter to continue to the next coordinate.
                   \> Press `q` to exit."
         done
         ;;        
         if [[ $var_name == "q" ]]; then
             exit 0
         elif [[ $var_name == "" ]]; then
             index=$index+2
         else
             index=$var_name
         fi;
     done
     ;;
esac

exit 0
