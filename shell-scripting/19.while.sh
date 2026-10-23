#!/bin/bash

while IFS= read -r line
do
 echo $line
done < 01.hello-world.sh
