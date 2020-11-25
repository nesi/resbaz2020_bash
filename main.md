# Bash scripting ~~and how to avoid it~~

***Questions***

* How can I ...
    - Save commands for later?
    - Automate tedious command line work?


***Objectives***

* You will learn ...
    - How to run a bash script
    - Basic structures (logic, loops, etc)
    - How to make and use aliases
    - How to make and use functions


### What is a Bash script?

[`e1_whatis.sh`](./e1_whatis.sh)

Bash scripts are *text* files containing a series of *bash commands*.

Everything is *text*.

`.sh` is convention, has no effect on execution.

---

Scripts can be run using the `bash` command e.g:

```bash {}
bash e1_whatis.sh
```
```bash {}
bash ~/resbaz_bash_2020/e1_whatis.sh
```

Or by calling them directly:
```bash {}
~/resbaz_bash_2020/e1_whatis.sh
```

For a script in the same directory as you:

```bash {}
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

Subshells are child processes that inherit the environment of their parent.

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

-n, -z, -w, -eq, -lt, -gt, -ne, 


Return codes and subshells...
```bash{cmd}
if ! mkdir "new_directory"
then
    echo "directory could not be made."
fi
```

We will cover more of this later.

---
[`e2_basics.sh`](./e2_basics.sh)

@import "./e2_basics.sh"
---
**Questions!?**
### Workflows
#### Arguments

When running a script anything following the name of the script is an *argument*.
Separated by space (unless in "double quotes").

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

# ~~Bash scripting~~ and how to avoid it
Bash isn't just a tool, it's your "home." Personalising your Bash 
makes it easier and more pleasant to work in the environment

In this half, I am going to go through a bunch of examples
- don't worry if you don't remember everything
- the most important take-aways are the concepts, not the commands

#### Splash Screen Example

```

              .,-:;//;:=,
          . :H@@@MM@M#H/.,+%;,
       ,/X+ +M@@M@MM%=,-%HMMM@X/,
     -+@MM; $M@@MH+-,;XMMMM@MMMM@+-
   ;@M@@M- XM@X;. -+XXXXXHHH@M@M#@/.
 ,%MM@@MH ,@%=             .---=-=:=,.
 =@#@@@MX.,                -%HX$$%%%:;
=-./@M@M$                   .;@MMMM@MM:
X@/ -$MM/                    . +MM@@@M$
,@M@H: :@:                    . =X#@@@@- ======================================
,@@@MMX, .                    /H- ;@M@M= Welcome to Aperture Science, eper363.
.H@@@@M@+,                    %MM+..%#$. ======================================
 /MMMM@MMH/.                  XM@MH; =;
  /%+%$XHH@$=              , .H@@@@MX,
  .=--------.           -%H.,@@@@@MX,
   .%MM@@@HHHXX$$$%+- .:$MMX =M@@MM%.
     =XMMM@MM@MM#H;,-+HMM@M+ /MMMX=
        =%@M@M#@$-.=MM@@@M; %M%=
         ,:+$+-,/H#MMMMMMM@= =,
              =++%%%%+/:-.

==============================================================================

eper363> 
```

#### Text to Speech Example
(demo)
```bash {cmd}
echo "Hello, ResBaz" | say -v Lee
```

#### A Clock for the terminal
(demo)
```bash {cmd}
redclock
```

### How to configure my terminal?
Make changes in `.bash_profile` or `.bashrc`
- Your own customisations go in here
- When in doubt, use `.bash_profile`
    - the file may not exist yet, create it
    - generally, `.bash_profile` is sourced once per login shell, and `.bashrc` is sourced every time you open a new terminal window
    - can be the source of mysterious errors
- there's nothing magic about these files. They're just configurations
    - bash sources them for you

### What is "sourcing"?
- Earlier, Callum taught us about subshells 
- (running and instance of `bash` inside of `bash`)
- a subshell is created when we run a bash script
- **in contrast**, sourcing runs the script, or configuration file, in the current shell
- this is useful because you can set variables, functions, and aliases

```bash {cmd}
eper363> yellowclock
-bash: yellowclock: command not found
eper363> source source_me.sh
eper363> yellowclock
```

#### Variables
Some examples:

`PATH` - where Bash searches for executables
```bash
echo $PATH | tr ':' '\n'
```
```
/home/eper363/bin
/usr/local/sbin
/usr/local/bin
/usr/sbin
/usr/bin
/sbin
/bin
```
You must append to `PATH` if you want to find executables in arbitrary directories
- (show my bash_profile and `PATH` variable)

`$PS1` and `$PS2` -  the look and feel of your prompt

```bash
echo $PS2
echo $PS1
```

I like to keep mine simple. There are more complicated examples, like showing your current working directory
- search for tutorials online and have a go at it
- decorate, and make Bash your home!

#### Setting Variables 


set is for changing shell options
```bash
set +o noclobber
```

Example:
```bash
touch foo
echo "can I clobber foo?" > foo
```

Local changes
```bash
PS2=">>>>>>>> "
```

Changes can be exported to child shells.
Useful for modifying `PATH`
```bash
export CLICOLOR=1
```

show examples in my .bash_profile

#### Functions
Functions are pieces of code that can be re-used in scripts

Here we will demo some simple functions

One-off functions are  useful when the commands are unwieldy to enter on cmdline

```
timestamp() {
  date +'%Y-%m-%d_%H-%M-%S'
}
```

```bash {cmd}
targz() { tar -zcvf $1.tar.gz $1; rm -r $1; }
untargz() { tar -zxvf $1; rm -r $1; }
```

`source fn_source_me.sh` and do demo


#### Aliases
Aliases are *text substitutions*.
You can use them as shortcuts.

When an alias is called, the full text is substituted, then the command is executed.


Example of alias.

Overide `rm` with 'interactive' flag.
```bash {}
alias rm="rm -i"
```

Make directory and cd into it
```bash
alias mkcd=mkdir -p "$1";cd "$1";
```

Overide `ls` with 'list' flag.
```bash {}
alias ls="ls -l"
```

ls "tree"
```bash 
alias lstree='find ./ -type d -print | sed -e "s;[^/]*/; /;g;s;/ ;    ;g;s;^ /$;.;;s; /;|-- ;g"'
```

Helpful tips for productivity
```bash
alias synergize="curl -sL http://cbsg.sf.net | grep -Eo '^<li>(.*)</li>' | sed "s/\<li\>//g" | sed "s/\<\/li\>//g" | gshuf -n1"
```

```bash
alias weather='curl wttr.in'
```

#### Persistance 
When you `touch` a file, it stays where it is until it is moved or deleted

Aliases and function do not persist

This is why we put the definitions into our `.bash_profile`, which gets loaded when we log in.


#### One line commands.
`;` is the same as `enter`
Can compose multiple line commands.

```bash {cmd}
# print out zipped files (dry run)
for f in fastqc/*zip; do echo $f; done
```

This can be written in an expanded form:
```bash
for f in fastqc/*zip
    do echo $f
    done
```

Your bash command history "remembers" the compact version

```
# unzip compressed files
for f in fastqc/*zip; do unzip $f; done
```

*Note `;` can also be used to form tidier scripts*
```bash
    for a in inputs;do
        # Do something.
    done    
``` 

#### Avoiding Bash Scripting
I generally do not find myself writing bash scripts often
- once and a while I need to 
- most of the time, I use functions, aliases, and one-liners

Caveat
- if you are doing research, capture all your `bash` commands in a script
- for repeatability 
- show an `Example`


### Other Tips and Tricks (to help you avoid scripting)

#### Search history
to start searching:
- ctrl + r "cmd"

press `ctrl` + `r` again 
- to look farther back in your history

press `[enter]`
- to run the command again

I prefer to search for commands in my history

```bash
history | grep "alias"
```
it feels safer to me (prints out the command without executing)


#### Pipes
connects the output of one file to the input of another
- outputs are *usually* from the stdout stream
- inputs are *usually* from the stdin stream

Example without a pipe:

```bash
say "Hello, world" -v Lee
```

Example with a pipe:
```bash
echo "Hello, ResBaz" | say -v Lee
```

#### Redirects
write vs append
```bash
echo "hello, world" > bar

cat bar >> foo
```

#### Editors
#### Backgrounding and Foregrounding 
#### Jobs, Kill, ps
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
#### Functions

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

# functions from callums bashrc
Functions allow re-use of segment of code.
Function *similarly* to scripts in that they can take arguments.

They must be defined before they are used.



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