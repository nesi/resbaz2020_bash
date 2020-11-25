#!/bin/bash

echo "The script '$0' has been called with $# arguments."

# We can call specific arguments with...
echo "The first argument is '$1'"
echo "The second argument is '$2'"
echo "The third argument is '$3'"

# Or loop though them with...
count=0
for a in "$@"
do
    ((count+=1))
    echo "Argument $count is equal to $a"
done