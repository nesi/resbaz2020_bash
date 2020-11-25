## Bash scripting and how to avoid it

***Questions***

* How can I ...

***Objectives***

* Get gud ... 


### What is a Bash script?

[`e1_whatis.sh`](./e1_whatis.sh)

Bash scripts are *text* files containing a series of *bash commands*.

Everything is *text*.

`.sh` is convention, has no effect on execution.

---

Scripts can be run using the `bash` command e.g:

```bash {cmd}
bash e1_whatis.sh
```

Or by calling them directly:
```bash {cmd}
~/resbaz_bash_2020/e1_whatis.sh
```

For a script in the same directory as you:

```bash {cmd}
./e1_whatis.sh
```

---

Calling a script requires you have permission to *execute* the script.

Check permissions using:

```bash {cmd}
ls -l
```
The first block `---` are your permissions.

To add execute permissions:

```bash {cmd}
chmod u+x e1_whatis.sh
```

(`u`) user (`+`) add (`x`) execute

---
**Questions!?**

### Basics


#### Comments

`#` starts a comment. 
Everything after `#` on the same line is ignored.

```bash {cmd}
# echo "This is a comment"
echo "This isn't a comment"
```

#### `#!/bin/bash` *shebang*

Special type of comment, always the *first line of a script*.

Tells the system this file should be run by the program called *bash* located in the *bin* directory.
Flags can be added to the `#!/bin/bash` to modify how the code is executed.

`#!/bin/bash -e` Exit script on error.
`#!/bin/bash -x` Prints commands as executed.

#### Variables
Variables are declared using `=`, as you need them. 
Double quotes `""` ensures the contents are not broken on spaces.
Variables are referenced using `$` or `${}` (best practice).

```bash {cmd}
myvar="is a variable"
echo "This ${myvar}."
```

#### Subshells

Single parentheses `$()` will run the enclosed command in a *subshell*.
A subshell is another instance of bash running inside your script.
Whatever would usually be printed to your terminal will be substituted in place.

A very simple example.

```bash {cmd}
echo "The current directory is $(pwd)"
```

Can use pipes, filters, scripts... any bash command.

Generally this is how you will assign variables a value.

```bash {cmd}
n_dir=$(ls */ | wc -w)
n_files=$(ls -I */ | wc -w)
echo "There are ${n_dir} directories and ${n_files} files in $(pwd)"
```

Subshells are child proccesses that inherit the enviromenent of their parent.

Subshells are very cool.

```bash {cmd}
echo "this is a $(echo "subshell inside of a $(echo "subshell inside of a $(echo "subshell inside of a $(echo subshell)")")")"
```

#### Arithmetic Expansion
Statements enclosed within double brackets `(())` will be evaluated as mathematic expressions. `$(())` will evaluate *and* execute the output.

For example:

```bash {cmd}
echo $((2+2))
```


Insert example of (())
Including the `$` when referencing a *variable* inside `$(())` is optional.

```bash {cmd}
num1=100
num2=25

echo "${num1} divided by ${num2} is equal to $((num1/num2))"
```
#### Loops

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

This is where the bulk of the potential for automation lies.

#### Conditional Logic

We can use `if` `then` `fi` statements to control whether or not a block of code is executed.

`!` is a logical NOT

There are many ways to provide the conditional logic.

Pattern matching ``[[ ]]``
*(Old style `[ ]` should be avoided!)*


```bash {cmd}
my_name="Callum"
if [[ "$my_name" == C* ]]
then 
    echo "That is a good name"
fi
```

Arithmetic tests ``(( ))``

```bash {cmd}
n=9
if (( n < 10 ))
then
    echo "$n is less than 10"
fi
```

Boolean operators.

-n
-z
-w
-eq, -lt, -gt, -ne, 


Return codes and subshells...
```bash{cmd}
if ! mkdir "new_directory"
then
    echo "directory could not be made."
fi
```

We will cover more of this later.

Avoid sing square brakcets

Pause for questions.
---
[`e2_basics.sh`](./e2_basics.sh)

@import "./e2_basics.sh"

### Workflows
#### Arguments

When running a script anything following the name of the script is an *argument*.
Seperated by space (unless in "double quotes").

```bash
./my_script.sh argument1 argument2 "argument3. Still argument3"
```
make this an actual thing.

Within your script, the value of the first argument is assigned to the variable `$1`, the second `$2` and so on ....
The name of the script itself is assigned to `$0`.
The total number of arguments is assigned to `$#`.
All the arguments are included in `$@`.

[`e3_args.sh`](./e3_args.sh) 
@import "./e3_args.sh"

Another example.

[`e3_multiply.sh`](./e3_multiply.sh) 
@import "./e3_multiply.sh"

#### Piping 
Your scripts can be piped filtered or redirected just like any other command.

```bash {cmd}
./e3_multiply.sh 5 5 > output.txt
```

#### Functions


### Common Problems



Can be put inside your `.bash_profile` (coming soon).

### .bash_profile vs .bashrc
Say or may not have .bash profile.

### Sourcing
Thing you have to do.

#### Functions
Example of function in bash rc.
Unwealdy to enter on cmdline

# functions from callums bashrc
Functions allow re-use of segment of code.
Function *similarly* to scripts in that they can take arguments.

They must be defined before they are used.

```bash {cmd}
sum(){
    total=0
    for num in $@
    do
        ((total+=num))
    done
    echo "$total"
}

sum 15 9 18
```

```
function exitstatus() {
        EXITSTATUS="$?"
        echo -ne "\033]0;${HOSTNAME}\007"
        BOLD="\[\033[1m\]"
        RED="\[\033[1;31m\]"
        GREEN="\[\e[32;1m\]"
        BLUE="\[\e[34;1m\]"
        OFF="\[\033[m\]"
        LINE="\n" #\e]2;\$(pwd)\a\e]1;\$(pwd)\a$GREEN\$(s=\$(printf "%*s" \$COLUMNS); echo \${s// /―})\n\e[0m"
        PROMPT="${PROMPT_PREFIX}${BOLD}[\h \W"
        if [ $EXITSTATUS -eq 0 ]
        then
                PS1="${LINE}${PROMPT}${GREEN} SUCCESS${OFF}${BOLD} ]\$${OFF} "
        else
                PS1="${PROMPT}${RED} FAILURE${OFF}${BOLD} ]\$${OFF} "
        fi
        PS2="${BOLD}>${OFF} "
        }

PROMPT_COMMAND=exitstatus
```

```bash
function wess(){
        # Watches thing
        watch -cd -n 0.1 tail -n 50 $1 
}
```
```bash
function les(){
        #runs 'less' on most recent file
        less $(ls -at | head -1)
}
```
```bash
function wes(){
        # Watches most recent thing.
        watch -cd -n 0.1 tail -n 50 $(ls -at | head -1)
}
```
```bash
mkcd() { 
    mkdir -p "$@" && cd "$@"
}
```

#### Aliases
Aliases are *text substitutions*.
You can use them as shortcuts.

When an alias is called, the full text is substituted, then the command is executed.


Example of alias.

Overide `rm` with 'interactive' flag.
```bash {}
alias rm="rm -i"
```

Overide `ls` with 'list' flag.
```bash {}
alias ls="ls -l"
```

```bash
alias synergize="curl -sL http://cbsg.sf.net|grep -Eo '^<li>.*</li>'|sed s,\</\\?li\>,,g|shuf -n1"
```

Make directory and cd into it
```bash
alias mkcd=mkdir -p "$1";cd "$1";
```

Replaces `cat` command with image of cat.
```bash
alias cat="wget -qO - http://placekitten.com/$[500 + RANDOM % 500]|display"
```

```
[[ "$(date +%a)" == "$(last $USER|sed -n 2p|awk '{print$4}')" ]]||curl wttr.in
```

#### One line commands.
`;` is the same as `enter`
Can compose multiple line commands.

```bash {cmd}

for thing in cat file;do a thing; done
```

```
cd ~; ls; cd -;
```
*Note `;` can also be used to form tidyr scripts*
```bash
    for a in inputs;do
        # Do something.
    done    
``` 

#### Search history
ctrl + r "cmd"
press `ctrl` + `r` again 
echo HISTSIZE=10000 >> ~/.bashrc
#### Local
#### Export

A quick note on stdout
### Stdin, stdout, stderr, exit codes, arguments


#### Pipes
#### Redirects
#### /dev/null
#### /dev/tty
#### Editors

#### Backgrounding and Foregrounding 
#### Jobs, Kill, Nice, ps
#### Inheritence

```bash {cmd}
./e3_multiply.sh 10 
```

```bash {cmd}
./e3_multiply.sh 10 5
```