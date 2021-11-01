# Terminside
![Terminside Screenshot](https://github.com/zaenulhilmi/terminside.vim/blob/main/terminside-demo.gif)

## Introduction
Terminside is a tool to easily accessing terminal inside vim. It will toggle 
and show it as window at the bottom of the screen. Terminside can create 
multiple terminal that can be switched later.

## Background
When I need to do something using terminal, I have to open up a new terminal 
or prepare a separate window to do terminal stuff. Sometimes it just feel 
overwhelming, especially when I just need to do something as simple as doing 
```git status``` or ```npm run dev``` for certain project. I need to have a 
toggle for that inisde my vim. That's why I create a terminside, just a simple
tool for toggling a terminal and show it at the bottom window of vim. It can 
also create multiple instance of terminal so that I can do multiple stuff.


## Installation

Use your favorite plugin manager to install this plugin. For example using 
Vim-Plug

```
call plug#begin('~/.vim/plugged') 

Plug 'zaenulhilmi/terminside.vim'

call plug#end()

```

Install it using ```:PlugInstall```

## Getting Started

After installing terminside, by default it use ```Alt+0``` for toggling the 
terminal to open and close it. Inside a terminal, can use ```Alt+c``` to 
create a brand new terminal. ```Alt+n``` for switching to next terminal and 
```Alt+p``` for previous terminal.
In case you want something different or you already use the shortcut above,
you can put something like this inside your .vimrc if you use vim or init.vim 
if you use neo vim.

```
map <C-l> <Plug>TerminsideOpen;
tmap <C-l> <Plug>TerminsideClose;
tmap <leader>c <Plug>TerminsideNew;
tmap <leader>p <Plug>TerminsidePrev;
tmap <leader>n <Plug>TerminsideNext;

```

