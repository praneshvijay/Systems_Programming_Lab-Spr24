#! /bin/bash

#Function to print a single digit in 5x5 pattern
function print_digit_() {
    digit=$1
    row=$2
    if [ $row -eq 0 ]; then 
        case $digit in
            0) echo -n "  ---  ";;
            1) echo -n "     . ";;
            2) echo -n "  ---  ";;
            3) echo -n "  ---  ";;
            4) echo -n " .   . ";;
            5) echo -n "  ---  ";;
            6) echo -n "  ---  ";;
            7) echo -n "  ---  ";;
            8) echo -n "  ---  ";;
            9) echo -n "  ---  ";;
        esac
    elif [ $row -eq 1 ]; then 
        case $digit in
            0) echo -e -n " |   | ";;
            1) echo -e -n "     | ";;
            2) echo -e -n "     | ";;
            3) echo -e -n "     | ";;
            4) echo -e -n " |   | ";;
            5) echo -e -n " |     ";;
            6) echo -e -n " |     ";;
            7) echo -e -n "     | ";;
            8) echo -e -n " |   | ";;
            9) echo -e -n " |   | ";;
        esac
    elif [ $row -eq 2 ]; then 
        case $digit in
            0) echo -n " |   | ";;
            1) echo -n "     | ";;
            2) echo -n "  ---  ";;
            3) echo -n "  ---  ";;
            4) echo -n "  ---| ";;
            5) echo -n "  ---  ";;
            6) echo -n "  ---  ";;
            7) echo -n "     | ";;
            8) echo -n "  ---  ";;
            9) echo -n "  ---  ";;
        esac
    elif [ $row -eq 3 ]; then 
        case $digit in
            0) echo -n " |   | ";;
            1) echo -n "     | ";;
            2) echo -n " |     ";;
            3) echo -n "     | ";;
            4) echo -n "     | ";;
            5) echo -n "     | ";;
            6) echo -n " |   | ";;
            7) echo -n "     | ";;
            8) echo -n " |   | ";;
            9) echo -n "     | ";;
        esac
    elif [ $row -eq 4 ]; then 
        case $digit in
            0) echo -n "  ---  ";;
            1) echo -n "     . ";;
            2) echo -n "  ---  ";;
            3) echo -n "  ---  ";;
            4) echo -n "     . ";;
            5) echo -n "  ---  ";;
            6) echo -n "  ---  ";;
            7) echo -n "     . ";;
            8) echo -n "  ---  ";;
            9) echo -n "  ---  ";;
        esac
    fi
}

#Function to print the blinking colon
function print_colon_() {
    row=$1
    clock=$2
    if [ $((10#$clock%2)) -eq 1 ]
    then
        if [ $row -eq 0 ]; then 
            echo -n "       "
        elif [ $row -eq 1 ]; then 
            echo -n "   o   "
        elif [ $row -eq 2 ]; then 
            echo -n "       "
        elif [ $row -eq 3 ]; then 
            echo -n "   o   "
        elif [ $row -eq 4 ]; then 
            echo -n "       "
        fi
    else
        if [ $row -eq 0 ]; then 
            echo -n "       "
        elif [ $row -eq 1 ]; then 
            echo -n "       "
        elif [ $row -eq 2 ]; then 
            echo -n "       "
        elif [ $row -eq 3 ]; then 
            echo -n "       "
        elif [ $row -eq 4 ]; then 
            echo -n "       "
        fi
    fi
}

#Print the clock forever
while true; do
    clear
    clo=1
    # Get current date and time
    dateandtime=$(date +"%A %d %B %Y %I %M %S %p %Z")

    height=$(tput lines)
    verticalpad=$((($height-8)/2))
    for((j=0; j<verticalpad; j++))do
        echo " "
    done

    # Extract different fields
    read -r day date month year hour minute second meridian timezone <<< $dateandtime

    width=$(tput cols)
    horizontalpad=$((($width-68)/2)) #68 is the width of the clock
    for((j=0; j<horizontalpad; j++))do
        echo -n " "
    done

    # Print the date as a string
    echo "$day $date $month $year"

    for((j=0; j<horizontalpad; j++))do
        echo -n " "
    done

    echo -n "+"
    for((j=0; j<=65; j++)) do
        echo -n "-"
    done
    echo "+"

    for ((i=0; i<5; i++))do
        for((j=0; j<horizontalpad; j++))do
            echo -n " "
        done
        for ((j=0; j<${#hour}; j++)); do
            if [ $j -eq 0 ] 
            then echo -n "|    "
            fi
            print_digit_ "${hour:$j:1}" "$i"
        done 
        print_colon_ "$i" "$second"
        for ((j=0; j<${#minute}; j++)); do
            print_digit_ "${minute:$j:1}" "$i"
        done
        print_colon_ "$i" "$second"
        for ((j=0; j<${#second}; j++)); do
            print_digit_ "${second:$j:1}" "$i"
            if [ ! $j -eq 0 ]
                then if [ $i -eq 4 ]
                    then echo -n "   $meridian |"
                    else echo -n "      |"
                    fi
            fi
        done
        if [ $i != 4 ]; then 
            echo 
        fi
    done
    echo
    for((j=0; j<horizontalpad; j++))do
        echo -n " "
    done

    echo -n "+"
    for((j=0; j<=65; j++)) do
        echo -n "-"
    done
    echo "+"

    for((j=0; j<vpad; j++))do
        echo " "
    done
    clo=$((clo+1))
    clo=$((clo%2))
    # Wait for the user to hit return
    read -t 0.5 -r && break
done




