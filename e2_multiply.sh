#!/bin/bash

# $# is equal to the number of input arguments.
if [[ $# -lt 2 ]];then 
    echo "Error: '$0' requires two input arguments!"
    exit 1
fi

# $(()) evaluates arithmetic.
factor_1=$1
factor_2=$2

product=$((factor_1* factor_2))


echo "$1 x $2 is equal to ${product}"