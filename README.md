# bash-i3-blocks-train-status
[![Build Status](https://travis-ci.com/vgoehler/bash-i3-blocks-train-status.png)](https://travis-ci.com/vgoehler/bash-i3-blocks-train-status)
[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

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
