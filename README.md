# SysUpdate
update your packages across multiple package managers right into your terminal!

## steps to install (system edition):
1) clone the repo and enter the folder:
```
git clone https://github.com/damarts-the-not-so-smarts/SysUpdate.git
cd SysUpdate
```

2) give the install script permissions to run, this is done by either going into your file manager and finding the option to "Run as executable" or chmodding:
```
chmod +x ./install-system.sh
```

3) run the installer script:
```
./install-system.sh
```

## steps to install (user edition):
1) clone the repo and enter the folder:
```
git clone https://github.com/damarts-the-not-so-smarts/SysUpdate.git
cd SysUpdate
```

2) give the install script permissions to run, this is done by either going into your file manager and finding the option to "Run as executable" or chmodding:
```
chmod +x ./install-user.sh
```

3) run the installer script:
```
./install-user.sh
```

> notice: to get the command working (on most shells), make sure ~/.local/bin is added to your shell's $PATH variable (in ~/.bashrc or ~/.zshrc), find how on your shell's guides
if you want to run it regardless:
```
~/.local/bin/(name you chose in setup)
```


## steps to manual install:
1) read the install.sh script its tiny
2) done


## dependancies:
- chafa is needed to display the banner image, find how to install chafa for you specific linux distro. (its name on most package managers is `chafa` try that if you cant find it)
- if youre on an immutable distro that doesnt use ostree, use the brew package manager to install it
- if you dont have `chafa` in your repos, try compiling it  via git cloning its repository.
> notice: you wont need chafa to run the script, it will show a fallback banner


## reasons to use this
- because cool banner
- updates all secondary or other package managers
- flex on homies
