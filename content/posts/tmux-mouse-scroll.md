---
title: How to fix tmux mouse scrolling after 2.1 changes
author_name: Larissa Reis
kind: article
created_at: 2015-10-31
abstract: I updated tmux to the newest 2.1 version and surprise! my mouse configuration stopped working. This is thanks to a rewritten of mouse mode and it's pretty simple to fix.
tags:
  - tmux
---

I updated tmux to the newest 2.1 version and surprise! my mouse configuration
stopped working. According to the
[changelog](https://github.com/tmux/tmux/blob/master/CHANGES), mouse mode was
rewritten and made a lot simpler. All those options for `mouse-{resize,select}`
and `mode-mouse` were thrown away and replaced by one `mouse` that turns on the
support for mouse inside tmux.

From the manual,

    mouse [on | off]  If on, tmux captures the mouse and
                      allows mouse events to be bound as
                      key bindings. See the MOUSE SUPPORT
                      section for details.

I didn't want to do anything fancy, so just turning on mouse and using the
default bindings were enough to make mouse work again. There was only one little
problem: mouse scrolling was not working. Or rather, it worked only when I was
already inside copy-mode. Apparently the old behavior changed because people
couldn't agree on how it should work, like how many lines should be skipped. So
now tmux guys decided to keep it simple and let people configure themselves.

I'm using the configuration suggested
[here](https://www.reddit.com/r/tmux/comments/3paqoi/tmux_21_has_been_released/cw552qd)
to use the mouse scroll to automatically enter copy-mode to scroll back into
history and leave copy-mode when you're back at the bottom again. It also passes
through the key press instead of entering copy-mode if there is an alternate
screen, like mutt or less, that will handle the key themselves. I thought that
scrolling half a page was too much so in my tmux.conf I used scroll-up to skip
only one line at a time instead:

    # makes scroll work
    bind-key -T root WheelUpPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
    bind-key -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"
    bind-key -t vi-copy WheelUpPane scroll-up
    bind-key -t vi-copy WheelDownPane scroll-down

There is actually a lot of interesting new features introduced for version 2.1,
it's worth taking a look at the changelog.
