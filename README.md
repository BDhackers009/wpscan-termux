# wpscan-termux
This is the only script that can install wpscan tool directly in Termux without any error.

## Installation

```
$ yes | pkg up
$ curl -sL https://raw.githubusercontent.com/BDhackers009/wpscan-termux/main/wpscan_termux.sh | bash

```

## Run
Always run wpscan with termux-chroot otherwise you will face "read only file system error"

```
termux-chroot wpscan
```
alternatively you can make a script and then move that into your bin folder so that you can use that system widely

```
#!/bin/bash
args="$@"
termux-chroot wpscan "$args"
```
save this script into a file then make it executable with
 ```
chmod +x filename
```
then simply move that into your bin folder using
```
mv filename $PREFIX/bin
```
Now you can use filename to run wpscan :)
### DONE :)
