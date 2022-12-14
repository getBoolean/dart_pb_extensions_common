# Paperback Sources (Dart)

WARNING: This package is still very experimental and not ready for production use.
Bugs are expected and the API is subject to change.

## Features

Write extensions using Dart, a modern language with a strick type system and sound null safety.

The only exception is that the return types of methods annotated with `@JS()` are not validated
during runtime, so an incorrect type may "leak" into other Dart code and violate type system guarantees.
For any calls into JavaScript code that are not known to be safe in their return values, validate
the results manually with is checks.

## About Sources

Sources were a highly requested feature for Paperback as it allows users to read manga that are otherwise
not on Paperback (The default source of the app). The sources are community-driven, and may be updated
and changed without requiring an application update. This allows for a rolling development process,
implementing changes as they come in, rather than waiting for the application developer to implement new
sources and bugfixes.

## Usage

TODO: Example usage will be provided once the dart cli is implemented.

### Parsing

Instead of using porting Cheerio to Dart, we use the [html](https://pub.dev/packages/html) package to
parse HTML. If you prefer to use Cheerio, you can create the JS bindings yourself following the
[js package's README](https://pub.dev/packages/js). I did not implement it because of the complexity
of Cheerio's API, it is much easier to use the [html](https://pub.dev/packages/html) package.

## Developing A Source

To find out more about developing a source, check out the
[website](https://paperback.moe/help/contribution/extension-development/), use one of the current
implementations in the repo as an example, and/or be sure to ask in the [Discord](https://discord.gg/Ny83JV3)!
