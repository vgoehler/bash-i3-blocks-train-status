# bash-i3-blocks-train-status
An i3 wm blocks app for figuring out the train status of certain trains the develop needs to take.

## Requirements
- bash :smiley:
- curl
- xmllint

## i3blocks.conf
```config
# train status
[trains]
command=$HOME/path/to/script/train_delay_MRB.sh
interval=3600
markup=pango
color=#1BA3F8
```
