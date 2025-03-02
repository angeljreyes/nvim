# My nvim config
Started as a [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
fork, now it's fully customized to my needs and preferences.

## Windows Dependencies
Neovim >= 0.10.0 `winget install neovim`

- Git (for Lazy) `winget install git.git`
- [Nerd font](https://www.nerdfonts.com/font-downloads)
- fd (for Snacks.picker and VenvSelect) `winget install sharkdp.fd`
- Ripgrep (for Snacks.picker) `winget install burntsushi.ripgrep.gnu`
- Any [C compiler](https://winlibs.com) (for treesitter and fzf-native)
- Make (for fzf-native) `winget install ezwinports.make`
- tree-sitter-cli (for treesitter) `npm i -g tree-sitter-cli`
  - Node.js & NPM (for markdown-preview and coc) `winget install openjs.nodejs.lts`

## Debian Based Dependencies
Neovim >= 0.10.0
```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
```

- [Nerd font](https://www.nerdfonts.com/font-downloads)
- [fd](https://github.com/sharkdp/fd/releases/latest) (for Snacks.picker and VenvSelect)
  Recommended version ends with `x86_64-unknown-linux-gnu.tar.gz `. `.deb` might be broken
- [Ripgrep](https://github.com/BurntSushi/ripgrep/releases) (for Snacks.picker)
- Node.js & NPM (for markdown-preview)
  - Node Version Manager
    ```sh
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    nvm install --lts
    ```

## Arch Linux Dependencies
You can read or run [this script](https://github.com/DestopLine/dotfiles/blob/master/scripts/scripts/archdeps/nvim.sh):
```sh
curl -o- https://raw.githubusercontent.com/DestopLine/dotfiles/master/scripts/scripts/archdeps/nvim.sh | bash
```
