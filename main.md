# Bash scripting and how to avoid it

## What is a Bash script?

[`e1_simple.sh`](./e1_simple.sh)

Bash scripts are *text* files containing a series of *bash commands*.

Everything is *text*.

`.sh` is convention, has no effect on execution.

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

[`e2_multiply.sh`](./e2_multiply.sh)

### Comments

`#` starts a comment. Everything after on the same line is ignored.


### `#!/bin/bash` *shebang*

Special comment, always the *first line of a script*.

Signifies that this text file that should be run by the program called *bash* located in the *bin* directory.
Flags can be added to the shebang to modify how the code is executed.

`#!/bin/bash -e` Exit script on error.
`#!/bin/bash -x` Prints commands as executed.

### Variables
Variables are declared using '=', as you need them. Strings are declared within `""`.
Variables are referenced using `$` or `${}` (best practice).

```bash {cmd}
myvar="is a variable"
echo "This ${myvar}."
```

### Loops

Loops allow us to repeat a command or set of commands.

Many ways to control loops.

Simple arguments...

```bash {cmd}
for x in "alpha" "beta" "gamma"
do
    echo $x
done
```

Can use globbing...

```bash {cmd}
for filename in e*.sh
do
    echo $filename
done
```

Parameter expansion...
```bash {cmd}
for letter in {a..e}
do
    echo $letter
done
```

Or arithmetic expansion...
```bash {cmd}
for ((i=0; i<5; i++))
do
    echo $i
done
```

### Conditional Logic

We can use `if` statements to control whether or not a block of code is executed.

Pattern matching...

```bash {cmd}
my_name="Callum"
if [[ "$my_name" == C* ]]
then
    echo "That is a good name"
else
    echo "That is an ok name"
fi
```

Arathmatic tests...

```bash {cmd}
n=9
if (( n > 10 ))
then
    echo "$n is greater than 10"
else
    echo "$n is not greater than 10"
fi
```


### Arithmetic


```bash {cmd}
./e2_multiply.sh 10 
```

```bash {cmd}
./e2_multiply.sh 10 5
```



### Local

### Export

## $((1+1))

## Functions


### 
## Editors

## Stdin, stdout, stderr, exit codes, arguments

## Variables
### Arguments

Anything following the calling of a script is an *argument*.
Seperated by space (unless in "double quotes").

```bash
./my_script.sh argument1 argument2 "argument3. still argument3"
```

The value of the first argument is assigned to `$1` within your script, the second `$2` and so on ....
The name of the script itself is assigned to `$0`.
The number of arguments is assigned to `$#`.

### 
### Pipes
### Redirects
### /dev/null
### /dev/tty
## Subshells 

## Backgrounding and Foregrounding 
## Jobs, Kill, Nice, ps
## Inheritence
## Aliases 

# Things that would be nice.
## 


# \#!
