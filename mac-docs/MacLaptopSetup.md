- [Background](#background)
- [Trackpad Configuration](#trackpad-configuration)
- [Display Hidden System Files in Finder](#display-hidden-system-files-in-finder)
- [Terminal Setup](#terminal-setup)
  * [1. <a name='Installxcode'></a>Install xcode](#1--a-name--installxcode----a-install-xcode)
    + [1.1. <a name='Acceptxcodelicenseoncommandline'></a>Accept xcode license on command line](#11--a-name--acceptxcodelicenseoncommandline----a-accept-xcode-license-on-command-line)
  * [2. <a name='LockMacTerminaltodockbar'></a>Lock Mac Terminal to dock bar](#2--a-name--lockmacterminaltodockbar----a-lock-mac-terminal-to-dock-bar)
- [Zsh setup](#zsh-setup)
  * [3. <a name='Whatfilesaredelivered'></a>What files are delivered?](#3--a-name--whatfilesaredelivered----a-what-files-are-delivered-)
- [Creating the working directories](#creating-the-working-directories)
  * [4. <a name='Settingupyourworkdirectory'></a>Setting up your work directory](#4--a-name--settingupyourworkdirectory----a-setting-up-your-work-directory)
  * [5. <a name='createarootdirectory'></a>create a root directory](#5--a-name--createarootdirectory----a-create-a-root-directory)
  * [6. <a name='createseveralsub-directories.'></a>create several sub-directories.](#6--a-name--createseveralsub-directories----a-create-several-sub-directories)
- [Configure git and GitHub access](#configure-git-and-github-access)
  * [7. <a name='Setupglobalconfiguration'></a>Setup global configuration](#7--a-name--setupglobalconfiguration----a-setup-global-configuration)
  * [8. <a name='Usesshtokensforgithubaccess'></a>Use ssh tokens for github access](#8--a-name--usesshtokensforgithubaccess----a-use-ssh-tokens-for-github-access)
- [Editors](#editors)
  * [9. <a name='VimVI'></a>Vim (VI)](#9--a-name--vimvi----a-vim--vi-)
  * [10. <a name='VisualStudioCode'></a>Visual Studio Code](#10--a-name--visualstudiocode----a-visual-studio-code)
    + [10.1. <a name='InstallVisualStudioCode'></a>Install Visual Studio Code](#101--a-name--installvisualstudiocode----a-install-visual-studio-code)
- [Install Brew](#install-brew)
  * [11. <a name='Prerequisites'></a>Prerequisites](#11--a-name--prerequisites----a-prerequisites)
  * [12. <a name='Installation'></a>Installation](#12--a-name--installation----a-installation)
- [10.0. List of addtional tools that I have used:](#100-list-of-addtional-tools-that-i-have-used-)
- [Soft link icloud folder](#soft-link-icloud-folder)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


# Background

The following instructions are a little pedantic. I originally wrote these instructions to help facilitate a common environment for some of the engineers on my team who were coming over from an operations only background. No CLI or little coding experience.



---
# Trackpad Configuration

I tend to find the default trackpad behavior to be a pain due to the force needed to click the trackpad. Additionally there are some operations such as dragging windows, text selection or square selection for screen printing in which I think is better using the 3 finger selection operation that does not involve clicking the trackpad.

1. One finger touch select instead of the default 1-finger click.

            Open up System Settings->Trackpad

            Click enable "Tap to click";

2. Enabling 3 finger dragging or selection option. This option allows you to drag windows, text select or square selection with three finger touch.

            Open up System Settings->Accessibility

            Select the "Pointer Control".

            Select the "Trackpad Options".

            Enable "Draging style" with "three finger drag"

 


---
# Display Hidden System Files in Finder

Run the following commands in Terminal to allow Finder to display system files.  This can help with modifying hidden file such as .zshrc.

```
defaults write com.apple.finder AppleShowAllFiles YES
```

Hold the &#39;Option/alt&#39; key, then right click on the Finder icon in the dock and click Relaunch.

System files will display in your Finder.

---
# Terminal Setup

I used to install oh-my-zsh and some other additionall tooling. I have replaced this with the mac default terminal and zsh configurations.

##  1. <a name='Installxcode'></a>Install xcode
Make sure you installed xcode from appstore or from your company approved resources.
###  1.1. <a name='Acceptxcodelicenseoncommandline'></a>Accept xcode license on command line
In order to use xcode from the command line you need to accept the licnese terms.
```
sudo xcodebuild -license
```
  
##  2. <a name='LockMacTerminaltodockbar'></a>Lock Mac Terminal to dock bar

In order to have quick access to the terminal, configure Mac Terminal to stay in doc bar.

- Start Mac Terminal from the Application menu.
> Applications->Utilities->Terminal
- Once Mac Terminal is opened do a right-click on the Terminal icon and click &quot;Options->Keep In Doc&quot;

---
# Zsh setup

[!NOTE] 
As earlier stated I have moved away from oh-my-zsh due to bloat and security concerns. When you download oh-my-zsh it has every possible configurations. Although they are "turned off", there is still a great deal that happens behind the scene. The following configuration is straight forward and follows a more traditional zsh paradigm in my opinion.

[!IMPORTANT]
The following assumes that you have Google gcloud SDK installed in the normal $HOME/gcloud-cloud-sdk path.

``` 
mkdir ~/.zsh # make zsh home
cp -r zsh/* ~/.zsh # .zshrc and plugin directory to the newly created .zsh directory. 
mv ~/.zsh_history to ~/.zsh # move the history to the new home directory.
mv ~/.zshrc ~/.zshrc.backup # mv/backup current .zshrc file
ln -s ~/.zsh/.zshrc ~/.zshrc # Link .zshrc file in user home to .zshrc in .zsh directory. 
```
Restart your terminal

##  3. <a name='Whatfilesaredelivered'></a>What files are delivered?
There are thre main types of files that are used:
* .zshrc - is the main configuration file for zsh
* .zshrc-history - contains the shell history. Currently it is configured to 10k lines.  This can be configured in .zshrc
* plugin directory - This contains the plugins. They are also enabled via the .zshrc file. See the following for the [list of plugins](zsh/plugins/README.md)


# Creating the working directories

##  4. <a name='Settingupyourworkdirectory'></a>Setting up your work directory

As George Carlin says everyone needs [a place for their stuff.](https://www.youtube.com/watch?v=JLoge6QzcGY). 

[!NOTE]
The main point of this section is that it is typically best to have a single directory in your home account for your main stuff.

##  5. <a name='createarootdirectory'></a>create a root directory

```
mkdir ~/myjunk
```

##  6. <a name='createseveralsub-directories.'></a>create several sub-directories. 
This directory is used for managing GitHub repos and golang components Note: the "-p" option tells mkdir to create any intermediary directories.

```
mkdir -p ~/myjunk/projects
mkdir -p ~/myjunk/tools
```
---
# Configure git and GitHub access
[!NOTE]
The following may be neccessary or not for github access.

##  7. <a name='Setupglobalconfiguration'></a>Setup global configuration

```
git config --global user.name "your user name"
git config --global user.email "your email address"
```

##  8. <a name='Usesshtokensforgithubaccess'></a>Use ssh tokens for github access

In Github web account settings: create and add your ssh token in the "SSH & GPG" section. May be neccessary or not.


---
# Editors

You will soon find out that Text Edit **cannot** be used for modifying scripts or any other files as it tend to insert non-ascii characters as formatting directives. There are two editors that are used: vim (VI) ([https://www.vim.org](https://www.vim.org)) and visual studio code ([https://code.visualstudio.com](https://code.visualstudio.com)).

##  9. <a name='VimVI'></a>Vim (VI) 
[https://www.vim.org](https://www.vim.org)

One of vi&#39;s strengths is that it is available on all Macs and all linux distributions including the one we use to build our microservices. It other strengths is that it is light weight and very good for doing quick edits on a single file. The weakness is that there is a learning curb. but once you get a handle on the key sequence the same type of editing patterns is used by other programs.

- [https://www.guru99.com/the-vi-editor.html - explanation and video](https://www.guru99.com/the-vi-editor.html)
- [https://www.openvim.com - A good tutorial](https://www.openvim.com)

##  10. <a name='VisualStudioCode'></a>Visual Studio Code 
[https://code.visualstudio.com](https://code.visualstudio.com)

Unlike Vim, Visual Studio Code is a Microsoft developed IDE open-sourced editor. Visual Studio code is very similar to Atom. _Note: I have used Atom, in the past, but there were some performance and stability issues that were well documented by the community that has not plagued visual studio code._

###  10.1. <a name='InstallVisualStudioCode'></a>Install Visual Studio Code

[!NOTE]
Follow corporate guidelines on how to install.

Refer to the following to install Visual Studio Code: [VS Code Configuration](./../..//wiki/spaces/DI/pages/234193018/VS+Code+Configuration)

---
# Install Brew
[!NOTE]
Follow corporate guidelines for use of brew.

Although I tend to find dockertized alternatives for most of my tooling, Homebrew is another mechanisms for loading various tools.

Homebrew (Brew) is a package manager for Mac that simplifies the installation of various tools and command line interface programs. You can read more about brew [here](https://brew.sh/).

##  11. <a name='Prerequisites'></a>Prerequisites

Before installation ensure you have installed the &quot;command-line tools for Xcode&quot;. You can check to see if you have them installed by running the following cmd in iTerm

$ xcode-select --install

If the tools are already installed you will see a message saying they have already been installed otherwise it will initiate the installation procedure.

Alternatively you can install Xcode from the app store, but this contains a lot of unnecessary items that aren&#39;t needed at this time.

##  12. <a name='Installation'></a>Installation

- To install open up iTerm and paste the following line

/usr/bin/ruby -e &quot;$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)&quot;

- Follow the prompts within the terminal window to proceed with the installation. Note: It will ask you for your password in order to gain elevated privileges during the installation process
- Once completed run the following cmd to ensure everything went swimmingly. You should get a message saying &quot;Your system is ready to brew&quot;.

$ brew doctor

---
# 10.0. List of addtional tools that I have used:
* [helm](./helm.md)
* [MiniKube](./Minikube.md)
* [Git Flow Tool](./git-flow.md)
* [Tool to help assume role in AWS. Forked project.](https://github.com/roger-beathard/assume)
* [Tool for managing kubernetes namespace and context. kubectx & kubens](https://github.com/ahmetb/kubectx)
* [Multi-Stage Docker builds](https://medium.com/capital-one-tech/multi-stage-builds-and-dockerfile-b5866d9e2f84)



---
# Soft link icloud folder

The icloud folder is buried and is not easy to get at from the command line. The following softlink will make it readily accessible.

```ln -s  ~/Library/Mobile\ Documents/com\~apple\~CloudDocs ~/icloud```

