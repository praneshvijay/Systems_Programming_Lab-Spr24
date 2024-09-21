#! /bin/bash
# cfrac.sh: Continued fraction calculator.

function evalfrac() {
    echo -n "Enter the array of coefficients: "
    read -a coef
    n=${#coef[@]}
    if [ $n -eq 0 ]; then
        echo "No coefficients entered."
        return 1
    fi
    if [ $n -eq 1 ]; then
        echo "Result: ${coef[0]}"
        return 0
    fi
    b=1
    c=${coef[$n-1]}
    for ((i=n-2; i>=0; i--)); do
        a=${coef[$i]}
        d=$c
        c=$((a*c + b))
        b=$d
        
    done
    echo "The continued fraction evaluates to $c / $b = `echo "scale=10; $c / $b" | bc`"
    echo
    return 0
}

function gencfrac() {
    echo -n "Enter fraction (a / b): "
    #read in a / b format
    read a char b
    if [ "$char" != "/" ]; then
        echo "Not a valid fraction."
        return 1
    fi

    if [ $b -eq 0 ]; then
        echo "Denominator must be non-zero."
        return 1
    fi
    
    echo -n "The continued fraction expansion of $a / $b is: "
    while [ $b -ne 0 ]; do
        c=$((a / b))
        echo -n "$c "
        d=$b
        b=$((a - b*c))
        a=$d
    done
    echo
    return 0
}

evalfrac
gencfrac