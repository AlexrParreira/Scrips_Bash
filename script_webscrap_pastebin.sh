#!/bin/bash
rm templinks templinks2 2>/dev/null >/dev/null
touch templinks
touch templinks2

extrair(){
  # EXTRAI OS LINKS DO SITE | templinks
  link="$(curl -s "https://pastebin.pl/lists" | grep "first" | cut -d"=" -f3 |cut -d '"' -f2 |cut -d "/" -f5)"
  sleep 2
  for l in $link; do
    r="$(grep "$l" templinks)"
    if ["$r" == ""]; then echo $l >> templinks; fi
  done

}

acessar() {
  #ACESSA OS LINKS E FILTRA OS QUE CONTÉM DETERMINADA PALAVRA | templinks2
  for r in $1; do
    echo "$r" >> templinks2                              
    r2="$(curl -s "https://pastebin.pl/view/raw/$r" | grep "$2")";
    if [ "$r2" != "" ];then echo "https://pastebin.pl/view/raw/$r"; fi;
    sleep 2
  done

}
[ "$1" == "" ] && { clear;echo "[+] Uso: $0 \"string\""; exit; }
clear
echo "[+] Monitorando \"$1\" em pastebin.pl"
echo
while :;
do
  extrair
  link="$(diff templinks templinks2 | cut -d" " -f2 | grep -v ",")"
  acessar "$link" "$1"
  sleep 3
done
