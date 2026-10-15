#!/bin/bash
echo "Enter marks of the student"
read marks

if [ $marks -le 35 ] then
  echo "Stuudent is failed"
elif [$marks -gt 35 ] && [$marks -le 50 ] then
  echo "Student is passed with C grade"
elif [$marks -gt 50 ] && [$marks -le 70 ] then
  echo "Student is passed with B grade"
else
  echo "Student is passed with A grade"
fi

