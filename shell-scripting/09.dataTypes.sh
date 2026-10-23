#!/bin/bash
var1=10
var2=20
var3=Adi
echo "$var1+$var2"
echo "Sum is $(($var1+$var2+$var3))"

declare -i COUNT=10
COUNT=COUNT+1
echo "Count is : $COUNT"

FRUITES=("Apple" "Banana" "Mango" "Grapes")
echo "Fruites are : ${FRUITES[@]}"
echo "First frute is : ${FRUITES[0]}"

name="Adinarayana Y"
echo "Name is : ${name}enuganti"

