#!/bin/bash
index=1
size=$(wc -l < "$1")
re=[0-9]+$
case "$(uname -sr)" in
  # MAC OS
  Darwin*)
   echo 'Detected Mac OS X'
   open -a Safari && echo "Defaul Browser: Safari" || echo "No suitable 
browser find. Safari expected. Exit"; #exit 0
   while [ $index -le $size ]
   do
     i=$(sed -n $index"p" $1)
     if [ ${i:0:1} != "#" ]; then
       prev=$(($index+1))
       echo $(sed -n $prev"p" $1)
       open -a Safari $i 2> /dev/null &
     else
       echo $i
       next=`expr $index + 1`
       open -a Safari $(sed -n $next"p" $1) 2> /dev/null &
     fi;
     read -p "Press enter to continue, a number to access the coordinates, or [q] to exit: " var_name
     osascript shut_safari.sh
     while ! { [ "$var_name" == "q" ] || [ "$var_name" == "" ] || [[ $var_name =~ ${re} ]]; }
     do
       echo -e "Input not handled. Check that it respects the following criteria;
          \> Insert a suitable position; boundaries [1, $size]. Check with [grep -n] the index of the coordinates you are interested in.
          \> Press enter to continue to the next coordinate.
          \> Press [q] to exit.\n"
       read -p "Press enter to continue, a number to access the coordinates, or [q] to exit: " var_name
     done

     if [[ "$var_name" == "q" ]]; then
       exit 0
     elif [[ "$var_name" == "" ]]; then
       index=`expr $index + 2`
     elif [[ $(( $var_name*2 )) -gt $size ]]; then
       echo -e "Input not handled. Check that it respects the following criteria;
          \> Insert a suitable position; boundaries [1, $size]. Check with [grep -n] the index of the coordinates you are interested in."
     else
       index=$(( $var_name*2 ))
     fi;
   done
   ;;

   # LINUX OS
   Linux*)
     echo 'Detected OS: Linux'
     #Check if at least one suitable program is available
     if ! type firefox &> /dev/null && ! type google-chrome &> /dev/null; then
         echo "No suitable program found; check the installation of Firefox and/or Chrome"
         exit 0
     fi;

     
     #Select the tool to open the browser
     if type firefox &> /dev/null; then
         browser=firefox
     else
         browser=google-chrome
     fi;

     while [ $index -le $size ]
     do
         i=$(sed -n $index"p" $1)
         if [[ ${i:0:1} != "#" ]]; then
             prev=`expr $index - 1`
             echo $(sed -n $prev"p" $1)
             $browser $i 2> /dev/null &
         else
             echo $i
             next=`expr $index + 1`
             $browser $(sed -n $next"p" $1) 2> /dev/null &
         fi;
         read -p "Press enter to continue, a number to access the coordinates, or [q] to exit: " var_name
         wmctrl -a firefox; xdotool key Ctrl+w; wmctrl -r firefox -b add,shaded
         while ! { [ "$var_name" == "q" ] || [ "$var_name" == "" ] || [[ $var_name =~ ${re} ]]; }
         do
             echo -e "Input not handled. Check that it respects the following criteria;
                   \> Insert a suitable position; boundaries [1, $size]. Check with [grep -n] the index of the coordinates you are interested in.
                   \> Press enter to continue to the next coordinate.
                   \> Press [q] to exit.\n"
             read -p "Press enter to continue, a number to access the coordinates, or [q] to exit: " var_name
         done

         if [[ "$var_name" == "q" ]]; then
             exit 0
         elif [[ "$var_name" == "" ]]; then
             index=`expr $index + 2`
         elif [[ $(( $var_name*2 )) -gt $size ]]; then
             echo -e "Input not handled. Check that it respects the following criteria;
                   \> Insert a suitable position; boundaries [1, $size]. Check with [grep -n] the index of the coordinates you are interested in."
         else
             index=$(( $var_name*2 ))
         fi;
     done
     ;;
esac

exit 0
