## Git Aliases

Shorten various frequently used git aliases:

* `s` does `git status`
* `reset` does `git reset --hard`
* `reset <commit>` does `git reset --hard <commit>`
* `co <branch>` does `git checkout <branch>`.  You can tab autocomplete these branches.
* `cob <branch>` does `git checkout -b <branch>` (make a branch)
* `gf` does `git fetch`
* `gb` does `git branch` (see your branches)
* `clone <git username> <repo name>` shortens `git clone` by not requiring the URL (though you can `clone <URL>` if you want to).  Also, will `cd` into the directory automatically.

Create new omnibus commands by merging things together:

* Whenever you checkout a branch, git status is run automatically.
* `cop <branch>` will checkout <branch>, pull, and then do git status.
* `cobm <branch>` will make a new branch called <branch>, but will checkout master and pull first (so you branch off of master)
* `fp` (full pull) will `git pull`, `bundle install`, and `bundle exec rake db:migrate`
* `cofp <branch>` will checkout <branch> and then full pull.
* `backmerge` will backmerge master by checking out master, pulling master, checking out your previous branch, and `git merge origin/master` that branch.
* `ruby_backmerge` will do `backmerge`, except with `bundle` and `migrate` included on master.
* `dif` shows you the output of both `git diff` and `git status`.
* `prune <branch>` will delete that branch both locally and on git.

No changes are made to anything involving `git checkout`, `git push`, or `git pull`, because these functionalities are turbocharged by [Send.zsh](https://github.com/robertzk/send.zsh) and [Send.vim](https://github.com/peterhurford/send.vim).


## Installation

### Oh-My-Zsh

Assuming you have [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), you can
simply write:

```bash
git clone git@github.com:peterhurford/git-aliases.zsh.git ~/.oh-my-zsh/custom/plugins/git-aliases
echo "plugins+=(git-aliases)" >> ~/.zshrc
```

(Alternatively, you can place the `git-aliases` plugin in the `plugins=(...)` local in your `~/.zshrc` manually.)

(Once you have this plugin, you can clone this plugin via `clone peterhurford git-aliases.zsh` instead.  Much better!)

### Antigen
If you're using the [Antigen](https://github.com/zsh-users/antigen) framework for ZSH, all you have to do is add `antigen bundle peterhurford/git-aliases.zsh` to your `.zshrc` wherever you're adding your other antigen bundles. Antigen will automatically clone the repo and add it to your antigen configuration the next time you open a new shell.

### Bash
If you use the non-recommended alternative, bash, you can install this directly to you
r `~/.bash_profile`:

```bash
curl -s https://raw.githubusercontent.com/peterhurford/git-aliases.zsh/master/git-aliases.plugin.zsh >>
~/.bash_profile
```


## Customization

* If you don't want to run `git status` with every branch change, put `GIT_ALIASES_SILENCE_GIT_STATUS=1` into your `.zshrc` (or `.bash_profile`).

* If you want to automatically push a new branch upon branch creation (e.g., commit "S
tarted <branchname>" with the creation of branch <branchname>), put `GIT_APLIASES_AUTO
PUSH_NEW_BRANCH=1` into your `.zshrc` (or `.bash_profile`).


## Why use this instead of the "git" plugin?
[Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/) already has a [git plugin](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git) you can optionally install that has aliases.

I obviously prefer my plugin better -- it has alias names that make more sense to me, and it has more complex aliases that make working on things much easier (especially Ru projects with built in `bundle` and `migrate`), and stuff like autopush on new branch is really neeat.  But if you don't work with Ruby and don't like some of the style choices I made (though feel free to suggest options for futher customizations, see above), you might prefer that plugin instead.


## Why can't I use them both?
Pick a side, we're at war!

But in seriousness, I think if you use them both (include both in your plugin line), nothing crashes and they don't interfere much with each other.  You'll be able to use the custom commands both here and there (i.e., both `gco` and `co` will work to do `git checkout`) and nothing in either plugin overwrites functionality of the other plugin.


## Help! Tab completion isn't working for branch names like you said!
To fix this bug, if you have either `autoload -U compinit && compinit` or `setopt completealiases` in your `.zshrc`, remove them.

If that doesn't work, you may have to include `unsetopt completealiases`, because it is being set somewhere else.  Though doing this may break the functionality of a different plugin.

If the problem still persists, it's a problem I haven't encountered myself yet.  Good luck.


## If you like this, you might also like...
* [Send.zsh](https://github.com/robertzk/send.zsh), a git command by robertzk that combines `git add .`, `git commit -a -m`, and `git push origin <branch>`.
* [Send.vim](https://github.com/peterhurford/send.vim), a vim plugin by me to do the above _without leaving vim_.
* [Git-it-on.zsh](https://github.com/peterhurford/git-it-on.zsh), git commands to open files on GitHub from the command line.
