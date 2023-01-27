# Paperback Sources (Dart)

Status: **In Development**

While the majority of major tasks have been completed, there is still a number of bugs to be fixed

- [x] Dart bindings for the Paperback Source models
- [x] Make `Source` methods return `Future` instead of JS's `Promise`, which would allow the keyword
`await` to be used.
- [x] Allow certain class methods to interop with JavaScript via `allowInterop`
  - [x] Register any source and its methods with `allowInterop`
- [x] Allow source info to be accessed from JavaScript
  - [x] Register any source info with dart:js' `context`
- [x] Dart Toolchain CLI
  - [x] Bundle
  - [x] Serve
  - [x] Homepage generation
- [ ] Testing
- [ ] Documentation
- [ ] Template repository
- [ ] Run on iOS' JavaScriptCore

## Paperback Extensions Common

Common models for extensions used by Paperback v0.6 - v0.7, written in Dart.

## Features

Write extensions using Dart, a modern language with a strick type system and sound null safety.

The only exception is that the return types of methods annotated with `@JS()` are not validated
during runtime, so an incorrect type may "leak" into other Dart code and violate type system guarantees.
For any calls into JavaScript code that are not known to be safe in their return values, validate
the results manually with `is` checks.

## About Sources

Sources were a highly requested feature for Paperback as it allows users to read manga that are otherwise
not on Paperback (The default source of the app). The sources are community-driven, and may be updated
and changed without requiring an application update. This allows for a rolling development process,
implementing changes as they come in, rather than waiting for the application developer to implement new
sources and bugfixes.

## Usage

TODO: Example usage will be provided once the dart cli is implemented.

### Parsing

Instead of using/porting Cheerio to Dart, we use the [html](https://pub.dev/packages/html) package to
parse HTML. The `Parser` object is provided by the parent class. If you prefer to use Cheerio, you can create the JS bindings yourself following the
[js package's README](https://pub.dev/packages/js). I did not implement it because of the complexity
of Cheerio's API, it is much easier to use the [html](https://pub.dev/packages/html) package.

## Developing A Source

To find out more about developing a source, check out the
[website](https://paperback.moe/help/contribution/extension-development/), use one of the current
implementations in the repo as an example, and/or be sure to ask in the [Discord](https://discord.gg/Ny83JV3)!
