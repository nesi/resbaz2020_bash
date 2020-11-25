## Bash scripting and how to avoid it

-Objectives
-Questions this will answer


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

[`e2_basics.sh`](./e2_basics.sh)

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

Pattern matching...

```bash {cmd}
my_name="Callum"
if [[ "$my_name" == C* ]]
then 
    echo "That is a good name"
fi
```

Arithmetic tests...simple

```bash {cmd}
n=9
if (( n < 10 ))
then
    echo "$n is not greater than 10"
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

```bash{cmd}
./e2_basics.sh
```
### Workflows
[`e3_multiply.sh`](./e3_multiply.sh)

#### Arguments

When running a script anything following the name of the script is an *argument*.
Seperated by space (unless in "double quotes").

```bash
./my_script.sh argument1 argument2 "argument3. Still argument3"
```
make this an ac tual thing.

Within your script, the value of the first argument is assigned to the variable `$1`, the second `$2` and so on ....
The name of the script itself is assigned to `$0`.
The total number of arguments is assigned to `$#`.
All the arguments are included in `$@`.


```bash {cmd}
./e3_multiply.sh 10 
```

```bash {cmd}
./e3_multiply.sh 10 5
```

#### Piping 
Your scripts can be piped filtered or redirected just like any other command.

```bash {cmd}
./e3_multiply.sh 5 5 > output.txt
```

#### Functions

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

### Common Problems



Can be put inside your `.bash_profile` (coming soon).

### .bash_profile vs .bashrc
Say or may not have .bash profile.

### Sourcing
Thing you have to do.

#### Functions
Example of function in bash rc.
Unwealdy to enter on cmdline

#### Aliases
Example of alias.
Why over function. More of shortcut.
`alias l=ls`

#### One line commands.
`;` is the same as `enter`
Can compose multiple line commands.

```bash {cmd}

for thing in cat file;do a thing; done
```

```
cd ~; ls; cd -;
```

#### Search history
ctrl + r "cmd"
press `ctrl` + `r` again 
echo histsize=10000 > ~/.bashrc
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