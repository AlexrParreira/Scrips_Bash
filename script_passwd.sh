#!/bin/bash

#Alerta de wordlist
if ["$1" == ""]; then
  echo
  echo "Uso $0 wordlist.txt"
  exit
fi

dos2unix $1 >> /dev/null # transforma o arquivo em unix

# cripitografa as wordlist
for word in $(cat $1); do
 md5="$(echo -n "$word" | md5sum | cut -d" " -f1)"
 b64="$(echo -n "$word" | base64)"
 sha256="$(echo -n "$word" | sha256sum| cut -d" " -f1)"

 echo "$word:$md5:$b64:$sha256"

done >> temp$1 # direciona para o arquivo temporario

cat temp$1 | column -s: -t >> "$1.final" # copia o temp para um arquivo

rm temp$1 # deleta o temp
