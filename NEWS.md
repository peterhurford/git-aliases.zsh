## Version 1.3

* Adds `copm` and `com` to quickly checkout master.

## Version 1.2

* Adds `rebase` to start an interactive `git rebase` of master into the current branch, `continue_rebase` to continue the rebase, and `end_rebase` to end a rebase.

## Version 1.1.5

* Amends `reset` to either `git reset --hard` if there are no arguments or reset a particular file with `git reset <FILE>` (via executing `git checkout <current branch> <filename>`).

## Version 1.1.4

* Adds `backmerge_dev` as an alias for backmerging from `dev` branch.

## Version 1.1.3

* Amends `cobd` and `corbd` to branch through `dev` branch (instead of `master`) for workflows where `dev` branch is the main development branch.

#### Version 1.1.2

* Amends most git actions to contain `&&` piping for safer operations.

#### Version 1.1.1

* Amends backmerging to pull the current branch first, before backmerging.

## Version 1.1

* Adds `release` to automatically tag and release a repository.
