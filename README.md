# Cloudruler

Cloudruler is a management tool for AWS CloudFormation inspired by Itamae.

## Installation

```bash
$ gem install cloudruler
```

## Usage

Create new cloudruler project

```bash
$ cloudruler init sample_project
```

And then execute

```
$ cloudruler dump templates/sample.rb
```

```bash
$ cloudruler help
Commands:
  cloudruler dump TEMPLATE_FILE  # Dump resolved template
  cloudruler help [COMMAND]      # Describe available commands or one specific command
  cloudruler init NAME           # Create a new cloudruler project
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pataiji/cloudruler.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
