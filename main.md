# Bash scripting and how to avoid it

## What is a bash script

[`e1_simple.sh`](./e1_simple.sh)

Bash scripts are *text* files containing a series of bash commands.

Everything is text.

`.sh` is convention, has no a/effect on execution.

---

Scripts can be run using the `bash` command e.g:

```bash {cmd}
bash e1_simple.sh
```

Or by calling them directly:

```bash {cmd}
~/resbaz_bash_2020/e1_simple.sh
```

For a script in the same directory as you:

```bash {cmd}
./e1_simple.sh
```

```python {cmd=/usr/bin/python3.8}

print([ x**2 for x in range(1,10)])

```

---

Calling a script requires you have permission to *execute* the script.

Check permissions using:

```bash {cmd}
ls -l
```

To add execute permissions:

```bash {cmd}
chmod u+x e1_simple.sh
```

(`u`) user (`+`) add (`x`) execute

## Basics

[`e2_multiply.sh`](./e2_multiply.sh)@ext:timonwong.shellcheck

`#` starts a comment.

Variables are declared on the fly. `""` clarify a string.


Variables are referenced using `$` or `${}` (best practice).

```bash {cmd}
myvar="is a variable"
echo "this ${myvar}"
```


### `#/bin/bash` (shebang)

Special comment, always the first line.

Signifies that this text file that should be run by bash (e.g the program called 'bash' located in the 'bin' directory).
Flags can be added to the shebang to modify how the code is executed.

`#!/bin/bash -e` Exit script on error.
`#!/bin/bash -x` Prints commands as executed.

### Arguments

Any words following the calling of a script is an *argument*
Seperated by space (unless in "double quotes").

`cmd argument1 argument2 "argument3. still argument3"`

### Arithmetic

### Local

### Export

## $((1+1))


### 
## Editors

## Stdin, stdout, stderr, exit codes, arguments

## Variables

### 
### Pipes
### Redirects
### /dev/null
### /dev/tty
## Subshells 
## Functions
## Loops
## Backgrounding and Foregrounding 
## Jobs, Kill, Nice, ps
## Inheritence
## Aliases 

# Things that would be nice.
## 