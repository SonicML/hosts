#!/bin/bash

function verify-IP() {
  local address="$1"
  local name="$2"
  
  line=`nslookup "$name" | grep "Address:" | head -n 2 | tail -n 1` 
  if [[ "$line" != "Address: $address" ]]; then
      echo "Bogus IP for $name"
      return 1
  fi 
  return 0
}

filename=$1

if [[ ! -f "$filename" ]]; then
  echo "$filename does not exist"
  exit 1
fi

grep -e '^[0-9]' $filename | grep -v "::" | while read -r word1 word2; do
  verify-IP $word1 $word2 
done


