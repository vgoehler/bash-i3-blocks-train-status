#!/bin/bash
# this script is ment for i3 wm blocks; it uses pango style and queries a trainline website for information about the state of two trains
# if this state is endangered it echos the trainsymbol in red in other cases blue

WEBSITE='https://www.mitteldeutsche-regiobahn.de/de/strecken/linienuebersicht-fahrplaene/linie/'
TRAIN_CONNECTION[0]='re-3-dresden-hof'
TRAIN_TEXT[0]='RE3'
TRAIN_CONNECTION[1]='rb-30-dresden-zwickau'
TRAIN_TEXT[1]='RB30'
SYMBOL=''
TEMP='temp.html'

# first argument is the variable index; second is the max length of array
function spaceBetween() {
    [ $1 -eq $(expr $2 - 1) ] || printf "%s" " "
}

# first argument the array to echo
function echoArray() {
    NAME=$1[@]
    ARRAY=("${!NAME}") # use parameter expansion to get array by name
    ARLEN=${#ARRAY[@]}
    for (( i=0; i < $ARLEN; i++ ));
    do
        printf "%s" "${ARRAY[$i]}"
        spaceBetween "$i" "$ARLEN"
    done
}

# try pipe
var="$(cat)"
echo "$var"


TLEN=${#TRAIN_TEXT[@]}
for (( i=0; i < ${TLEN}; i++ ));
do
    TEMP=$(curl -s "$WEBSITE${TRAIN_CONNECTION[$i]}")
    PROBLEM=$(echo "$TEMP" | xmllint --html --xpath //h2[@id=akutmeldungen]/following::div[1]/div - 2>/dev/null)

    if [ -z "$PROBLEM" ]
    then
        COLOR="#FF0080"
    else
        COLOR="#0080FF"
    fi;
    TRAIN_INFORMATION[$i]="<span font='FontAwesome' color='$COLOR'>$SYMBOL</span>"
    TRAIN_INFORMATION_LONG[$i]="<span weight='bold'>${TRAIN_TEXT[$i]}:</span>${TRAIN_INFORMATION[$i]}"
done
# Ausgabe blaues Zugsymbol bzw rotes Zugsymbol
# first line long text
echoArray TRAIN_INFORMATION_LONG
printf "\n"
# second line short text
echoArray TRAIN_INFORMATION

