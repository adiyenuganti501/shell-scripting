#1/bin/bash

sed 's/Rama/Adi/' adi.txt  # changes the first occurrence of "Rama" to "Adi" in the file adi.txt and prints the result to standard output.
sed -i 's/Rama/Adi/' adi.txt  # changes the first occurrence of "Rama" to "Adi" in the file adi.txt and saves the changes to the file.
sed 