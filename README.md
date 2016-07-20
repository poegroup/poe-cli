# poe-cli

An command line interface for managing poe web applications.

## Installation

    npm i -g poe

## Commands

Three commands are available: `create`, `config`, and `start`

## Examples

Issuing the `create` command will prompt you for any necessary fields before continuing.

    poe create api
    # project:
    # username:
    # description:
    # etc

Alternatively, you may pass the fields as arguments.

    poe create ui --project my-app --username mndvns --description 'This my app'

Frequently used fields may be saved via `config`...

    poe config --username mndvns

...which are used and read before every command, but may be overwritten by passed arguments.

## Creating apps

The `create` command instantiates a webapp of different types with minimal
configuration. The idea is to have an app up and running (even deployed) in
a matter of seconds.

Right now the available app templates are
- `static`, a static site run by [poe-static](https://github.com/poegroup/poe-static)
- `ui`, a client-facing webapp that runs [poe-ui](https://github.com/poegroup/poe-ui)
- `api`, a server running on [mazurka](https://github.com/exstruct/mazurka)

### Usage

Via `poe create --help`

    Usage: poe create [options] [type]

    Options:

      -h, --help     output usage information
      -V, --version  output the version number
      --verbose      verbose loggin to stdout
      --fields       output the required fields
      --unsafe       do not ask before overwriting files
      --quick        do not ask for confirmation
      --no-color     do not apply colors to logs

    Types:

      static   a static app
      ui       a dynamic client app
      api      a web api

## Configuring

The `config` command lets you customize application fields that never/rarely change. The file
is stored in `~/.config/poe` if you choose to edit it yourself, but the `config` command makes
it trival.

### Usage

Via `poe config --help`

    Usage: poe config [options]

    Options:

      -h, --help             output usage information
      -V, --version          output the version number
      --username <username>  your github username
      --email <email>        your github email
      --fullname <fullname>  your fullname

## Starting

The `start` command (also the default command if a valid command is not provided) pipes
the arguments to `make`. In other words, running `poe start` or simply `poe` is the same
as running `make` in your app.

Since the arguments are fed directly to `make`, there are no options for this command.

## Todo

- tests
- combine app templates (api + ui)
- add private templates

## License

MIT
