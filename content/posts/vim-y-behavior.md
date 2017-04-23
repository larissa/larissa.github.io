---
title: Vim Y behavior and yankring
author_name: Larissa Reis
kind: article
created_at: 2015-07-13
abstract: I'm a loyal Vi(m) soldier in the Editors Holy War, but unfortunately there are some things on Vi(m) that just don't make sense to me. One of those things is the Y behavior.
tags:
  - vim
---

I'm a loyal Vi(m) soldier in the Editors Holy War, but unfortunately there are
some things on Vi(m) that just don't make sense to me. One of those things is
the `Y` behavior.

One of the cool things about Vim is that there is a pattern, a logic that
governs those seemingly chaotic commands. It combines simple commands to perform
tasks (like `d[elete]i[nner]w[ord]` and `d[elete]a[round]w[ord]`) and keeps a
certain pattern on how those commands are modified (like d/c and D/C). The yank
command, however, deviates from this last rule in a kind of annoying way.

Just to recap, `d` command deletes text over motion, while `c` changes text over
motion (or more accurately, deletes and enter insert mode). So `y`, as expected,
yanks text over motion. Both `d` and `c` have a correspondent `D` and `C`
command that deletes/changes text from current position until the end of the
line. So, naturally, you would expect `Y` to do that same, however, instead it
will copy the whole line! Even Vim documentation acknowledges how illogical that
is.

                                                            Y
    ["x]Y   yank [count] lines [into register x] (synonym for
            yy, linewise).  If you like "Y" to work from the
            cursor to the end of line (which is more logical,
            but not Vi-compatible) use ":map Y y$".

I've used that mapping the documentation suggests on my vimrc for so long that I
even forget that's not the original behavior. So imagine my surprise when `Y`
suddenly stops working after I enabled a few new plugins the other day.

It turns out [YankRing](http://www.vim.org/scripts/script.php?script_id=1234)
was overriding my map and using the default Vi(m) `Y` behavior.

    nnoremap Y :<C-U>YRYankCount 'Y'<CR>

Unfortunately yankring doesn't have a clean way of customizing mappings it uses
for each yankring key, so it created a workaround with a function
`YRRunAfterMaps()`, which yankring calls after it has created the maps. So to
get my beloved `Y` mapping back, all I have to do is use this function to set
the correct mapping on my vimrc:

    "make Y consistent with C and D on yankring
    function! YRRunAfterMaps()
      nnoremap <silent> Y   :<C-U>YRYankCount 'y$'<CR>
    endfunction


