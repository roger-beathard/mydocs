**Mac Laptop Setup**

- [Trackpad Configuration](#trackpad-configuration)
- [Display Hidden System Files in Finder](#display-hidden-system-files-in-finder)
- [Terminal Setup](#terminal-setup)
  * [Install xcode](#install-xcode)
    + [Accept xcode license on command line](#accept-xcode-license-on-command-line)
  * [Install iterm2](#install-iterm2)
  * [Lock iterm2 to &quot;doc bar&quot;](#lock-iterm2-to--quot-doc-bar-quot-)
  * [Install Oh My Zsh](#install-oh-my-zsh)
  * [Change the theme used by Oh My Zsh](#change-the-theme-used-by-oh-my-zsh)
  * [Install the Powerline fonts](#install-the-powerline-fonts)
  * [Configure iTerm to use the installed fonts](#configure-iterm-to-use-the-installed-fonts)
- [Creating the working directories](#creating-the-working-directories)
  * [Setting up your work directory](#setting-up-your-work-directory)
  * [create a root directory](#create-a-root-directory)
  * [create several sub-directories.](#create-several-sub-directories)
- [Configure git and GitHub access](#configure-git-and-github-access)
  * [Setup global configuration](#setup-global-configuration)
  * [Enable OSXkeychain as a credential helper](#enable-osxkeychain-as-a-credential-helper)
  * [Creating a personal access token for github](#creating-a-personal-access-token-for-github)
  * [Creating a personal access token for gitlab](#creating-a-personal-access-token-for-gitlab)
- [Install Docker](#install-docker)
- [Editors](#editors)
  * [Vim (VI)](#vim--vi-)
  * [Visual Studio Code](#visual-studio-code)
    + [Install Visual Studio Code](#install-visual-studio-code)
- [Install Brew](#install-brew)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
- [10.0. List of addtional tools that I have used:](#100-list-of-addtional-tools-that-i-have-used-)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

---
# Trackpad Configuration

I tend to find the default trackpad behavior to be a pain due to the force needed to click the trackpad. Additionally there are some operations such as dragging windows, text selection or square selection for screen printing in which I think is better using the 3 finger selection operation that does not involve clicking the trackpad.

1. One finger touch select instead of the default 1-finger click.

            Open up System Preferences->Trackpad

            In the Point&amp;Click section, enable &quot;Tap to click&quot;

2. Enabling 3 finger dragging or selection option. This option allows you to drag windows, text select or square selection with three finger touch.

            Open up System Preference->Accessibility

            Select the &quot;Mouse &amp; Trackpad&quot; option

            Select the "Trackpad Options".

            Enable draging option with "three finger drag"

 


---
# Display Hidden System Files in Finder

Run the following commands in Terminal to allow Finder to display system files.  This can help with modifying the .zsh\_myenv file once it has been installed (later in these instructions)

- "**defaults write com.apple.finder AppleShowAllFiles YES**";
- Press return. Hold the &#39;Option/alt&#39; key, then right click on the Finder icon in the dock and click Relaunch.

System files will display in your Finder.

---
# Terminal Setup

The following is used to setup the base environment used for PHD development teams. It is based on the following:

- iterm2 ([https://iterm2.com](https://iterm2.com)) - An enhanced terminal.
- zsh ([http://zsh.sourceforge.net](http://zsh.sourceforge.net)) - The base shell.
- Oh My zsh ([https://ohmyz.sh](https://ohmyz.sh)) - Framework for managing zsh configurations such as prompt enhancements
- Powerline fonts - Provide special fonts used in the command prompt
- Additional Oh My Zsh configurations
- PHD GCP tools.

## Install xcode
Make sure you installed xcode from appstore.
### Accept xcode license on command line
In order to use xcode from the command line you need to accept the licnese terms.
- "**sudo xcodebuild -license**"
  
## Install iterm2

Install the stable release of iterm2 from the iterm2 site. ([https://iterm2.com/downloads.html](https://iterm2.com/downloads.html)).

- The installation should ask your permission to copy application to your application folder.

## Lock iterm2 to &quot;doc bar&quot;

In order to have quick access to the terminal, configure iTerm to stay in doc bar.

- Start iterm2 from the Application menu.
- Once iTerm is opened do a right-click on the iTerm icon and click &quot;Options->Keep In Doc&quot;


## Install Oh My Zsh 

[https://ohmyz.sh](https://ohmyz.sh)

&quot;Oh my Zsh&quot; is a package the provides a better experience for zsh &quot;shell&quot;. One of the primary benefits is that it has a set of plugins and themes for presenting context specific information on where you are in the directory and the current state of your terminal session. (ie. are you in a git directory, which Kubernetes cluster configuration is active).

- Open up item and run the following command:

sh -c &quot;$(curl -fsSL [https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh](https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh))&quot;

- Restart iTerm.

## Change the theme used by Oh My Zsh

Although there are many themes that can be used in &quot;OhMyZsh&quot;In  iTerm issue the following command to change from robbyrussell them to &quot;agnoster&quot;

_sed -i.bak 's/ZSH_THEME=robbyrussell;/ZSH_THEME=agnoster;/g' .zshrc_

- Restart iTerm

At this point you should see a terminal session as shown below with some funky characters in the prompt. The next step will be to install a set of fonts to address.


## Install the Powerline fonts 

([https://github.com/powerline/fonts](https://github.com/powerline/fonts))

Run the following to install the fonts:

**Powerline font install script**


* git clone https://github.com/powerline/fonts.git --depth=1
* ./install.sh
* cd ..
* rm -rf fonts

## Configure iTerm to use the installed fonts

Now we need to tell iTerm to use the installed font

Open up the Preferences panel in iTerm
- Navigate to the &quot;Default&quot; profile in the Profiles tab.
- Select the Text tab
- Select the &quot;Change Font&quot; button.
- Select the &quot;Meslo LG M for Powerline&quot; from the selection as show below:
- Navigate to the Color tab and select &quot;Tango Dark&quot; from the &quot;Color Presets&quot; pull down menu.

The gibberish in the iTerm prompt should now be fixed and should look as follows:


---

# Creating the working directories

## Setting up your work directory

As George Carlin says everyone needs [a place for their stuff.](https://www.youtube.com/watch?v=JLoge6QzcGY)

## create a root directory

```
mkdir ~/myjunk
```

## create several sub-directories. 
This directory is used for managing GitHub repos and golang components Note: the "-p" option tells mkdir to create any intermediary directories.

```
mkdir -p ~/myjunk/projects
mkdir -p ~/myjunk/tools
```
---
# Configure git and GitHub access

## Setup global configuration

- git config --global user.name &quot;your user name ie. &quot;John Doe&quot;&quot;
- git config --global user.email &quot;your email address ie. johndoe@gmail.com&quot;

## Enable OSXkeychain as a credential helper

In order to keep git from having to ask you for your username password each time it needs to access GitHub. git will use the osxkeychain to store credential information. git needs to be told to use this mechanism. ([https://help.github.com/articles/caching-your-github-password-in-git/](https://help.github.com/articles/caching-your-github-password-in-git/)). Assuming you have not done these steps before just run the following

- git config --global credential.helper osxkeychain

## Creating a personal access token for github

To access GitHub you do not use your GitHub password but instead use a &quot;personal access token&quot; generated from GitHub. The following provides good information on setting this up. ([https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)).

In the scopes/permissions just select the repo section.

## Creating a personal access token for gitlab
https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html

To use the token:
https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token#using-a-token-on-the-command-line

---
# Install Docker

The following link can be used to install docker. [https://www.docker.com/get-started](https://www.docker.com/get-started) Just follow the links on the page related to mac desktop installation details.

---
# Editors

You will soon find out that Text Edit **cannot** be used for modifying scripts or any other files as it tend to insert non-ascii characters as formatting directives. There are two editors that are used: vim (VI) ([https://www.vim.org](https://www.vim.org)) and visual studio code ([https://code.visualstudio.com](https://code.visualstudio.com)).

## Vim (VI) 
[https://www.vim.org](https://www.vim.org)

One of vi&#39;s strengths is that it is available on all Macs and all linux distributions including the one we use to build our microservices. It other strengths is that it is light weight and very good for doing quick edits on a single file. The weakness is that there is a learning curb. but once you get a handle on the key sequence the same type of editing patterns is used by other programs.

- [https://www.guru99.com/the-vi-editor.html - explanation and video](https://www.guru99.com/the-vi-editor.html)
- [https://www.openvim.com - A good tutorial](https://www.openvim.com)

## Visual Studio Code 
[https://code.visualstudio.com](https://code.visualstudio.com)

Unlike Vim, Visual Studio Code is a Microsoft developed IDE open-sourced editor. Visual Studio code is very similar to Atom. _Note: The team used Atom at the start of development but there were some performance and stability issues that were well documented by the community that has not plagued visual studio code._

### Install Visual Studio Code

Refer to the following to install Visual Studio Code: [VS Code Configuration](./../..//wiki/spaces/DI/pages/234193018/VS+Code+Configuration)

---
# Install Brew

Although I tend to find dockertized alternatives for most of my tooling, Homebrew is another mechanisms for loading various tools.

Homebrew (Brew) is a package manager for Mac that simplifies the installation of various tools and command line interface programs. You can read more about brew [here](https://brew.sh/).

## Prerequisites

Before installation ensure you have installed the &quot;command-line tools for Xcode&quot;. You can check to see if you have them installed by running the following cmd in iTerm

$ xcode-select --install

If the tools are already installed you will see a message saying they have already been installed otherwise it will initiate the installation procedure.

Alternatively you can install Xcode from the app store, but this contains a lot of unnecessary items that aren&#39;t needed at this time.

## Installation

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
* [Tool to help assume role in AWS] (Forked project: https://github.com/roger-beathard/assume)
* [Tool for managing kubernetes namespace and context. kubectx & kubens](https://github.com/ahmetb/kubectx)
* [Multi-Stage Docker builds](./../..//wiki/spaces/DO/pages/803537541/Multi-Stage+Docker+builds)





