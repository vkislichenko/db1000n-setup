#!/bin/sh

if [ ! -d "$DB1000N_DIRECTORY" ]
then
  echo "Cloning db1000n to $DB1000N_DIRECTORY"
#  mkdir -p "$DB1000N_DIRECTORY"
#  git clone https://github.com/Arriven/db1000n.git "$DB1000N_DIRECTORY"
else
  echo "db1000n directory $DB1000N_DIRECTORY already exists"
fi