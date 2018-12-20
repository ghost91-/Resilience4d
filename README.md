# Resilience4d

A fault tolerance library for D inspired by [Reslience4j](https://github.com/resilience4j/resilience4j/).

## Getting Started

### Dub dependency
To use this package, put the following dependency into your project's dependencies section:

| Package format | Line to include in dependencies       |
| -------------- | ------------------------------------- |
| dub.json       | "resilience4d": "*"                   |
| dub.sdl        | dependency "resilience4d" version="*" |

### Quick start

Nothing useful has been implemented as of yet. As soon as this changes, a quick start guide will be provided here.

## Hacking

### Building the project

Building the project is a simple as running the following command:
```
dub build
```

### Running the tests
Resilience4d is is separated into several sub packages.
To run all tests for a given  sub package (e.g. `circuit-breaker`), run the following command in the project’s root directory:

```
dub test :<sub package>
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on the process for submitting issues and merge requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://gitlab.com/ghost91-/resilience4d/tags).

## Authors

* [**Johannes Loher**](https://gitlab.com/ghost91-)

See also the list of [contributors](https://gitlab.com/ghost91-/resilience4d/graphs/develop) who participated in this project.

## License

This project is licensed under the MIT License, see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

Resilience4d is heavily inspired by [Reslience4j](https://github.com/resilience4j/resilience4j/). Thanks a lot to everybody involved with that project.