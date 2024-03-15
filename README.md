# Tritip

Tritip is a command-line interface (CLI) tool that allows you to practice typing using any file. It's a terminal-based user interface (TUI) application written in OCaml.

## Features

- Select a file from your local system to practice typing.
- Interactive menu to navigate between files.
- Real-time feedback on your typing accuracy.

## Installation

Ensure you have OCaml and Dune installed on your machine. You can then clone the repository and build the project:

```sh
dune build
```

## Usage

After building the project, you can run the application with:

```sh
dune exec tritip
```

This will open an interactive menu where you can select a file to practice typing. Use the `j` and `k` keys to navigate the menu, and press `Enter` to select a file. Press `Esc` at any time to quit the application.

## TODO

- [ ] Stats reporting (time, #typed, #wrong, wpm)
- [ ] Long-term stats (lesson per file, aware of langauge, charts!)
- [ ] Skip comments in code
- [ ] Progress indicator while typing
- [ ] Virtual keyboard display
