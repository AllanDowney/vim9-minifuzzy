# minifuzzy.vim :mag_right:

- Simple Vim9 fuzzy finder wrapper
  forked from [hahdookin/minifuzzy.vim](https://github.com/hahdookin/minifuzzy.vim)

![Using minifuzzy.vim to search files in the current directory](images/minifuzzy.gif)

## :hammer: Installation

:warning: Only supported for vim >= 8.2, not nvim

Required [ **fd** ](https://github.com/sharkdp/fd/releases) binary in the `$PATH`

Install using vim's builtin plugin manager:

```sh
mkdir -p ~/.vim/pack/bundle/start
git clone https://github.com/hahdookin/minifuzzy.vim ~/.vim/pack/bundle/start/minifuzzy.vim
```

```vim
Plug 'AllanDowney/vim9-minifuzzy'
```

or

```vim
Plug 'hdookin/minifuzzy.vim'
```

## :alembic: Usage

The following mappings can be used to fuzzy find:

- `<leader>ff` -- Files in current working directory
- `<leader>fb` -- Buffers
- `<leader>fm` -- Most recently used files
- `<leader>fl` -- Lines in the current buffer

---
