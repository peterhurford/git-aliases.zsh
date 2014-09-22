## Git Aliases

Shorten various frequently used git aliases:

* `git status` is shortened to `s`.
* `git reset --hard` is shortened to `reset`.
* Git checkout is shortened to `co`.
* Making a branch is shortened to `cob <new branch name>`.
* `clone <git username> <repo name>` shortens `git clone` by not requiring the URL.

Create new omnibus commands by merging things together:

* Whenever you checkout a branch, git status is run automatically.
* `cop <branch>` will checkout <branch>, pull, and then do git status.
* `fp` (full pull) will `git pull`, `bundle install`, and `bundle exec rake db:migrate`
* `cofp <branch>` will checkout <branch> and then full pull.
* `backmerge` will backmerge master by checking out master, full pulling master, checking out your previous branch, and `git merge origin/master` that branch.
* `dif` shows you the output of both `git diff` and `git status`.
* `prune <branch>` will delete that branch both locally and on git.

## Installation


Assuming you have [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), you can
simply write:

```bash
git clone git@github.com:peterhurford/git-aliases.zsh.git ~/.oh-my-zsh/custom/plugins/git-aliases
echo "plugins+=(git-aliases)" >> ~/.zshrc
```

(Alternatively, you can place the `git-aliases` plugin in the `plugins=(...)` local in your `~/.zshrc` manually.)

If you use the non-recommended alternative, bash, you can install this directly to you
r `~/.bash_profile`:

```bash
curl -s https://raw.githubusercontent.com/peterhurford/git-aliases.zsh/master/git-aliases.plugin.zsh >>
~/.bash_profile
```

## If you like this, you might also like...
* [Send.zsh](https://github.com/robertzk/send.zsh), a git command by robertzk that combines `git add .`, `git commit -a -m`, and `git push origin <branch>`.
* [Send.vim](https://github.com/peterhurford/send.vim), a vim plugin by me to do the above _without leaving vim_.
