# git-everything

Flatten a git repository by checking out all the commits into a particular
folder.

### Installation

First, get [stack](https://docs.haskellstack.org/en/stable/README/), then
clone this folder and run it

```
git clone https://github.com/silky/git-everything.git git-everything
cd git-everything
stack install
```

### Usage

```
> git-everything --help

git-everything - flatten a git repository by commit.

Usage: git-everything [-r|--repo-dir ARG] (-d|--dest-dir ARG)
  Flatten a git repository by checking out all the commits into a particular
  folder.

Available options:
  -h,--help                Show this help text
  -r,--repo-dir ARG        The directory of the repository to flatten. Default:
                           "."
  -d,--dest-dir ARG        The output directory
```


Example:

```
git-everything -d ~/tmp/whatever
```

Check out all revisions of the current folder into the `~/tmp/whatever`
folder.
