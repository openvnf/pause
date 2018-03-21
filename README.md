# Pause

Implements an executable that is waiting for any of SIGTERM, SIGINT or SIGCHLD
signals and exits once received.

## Build

Build process requires the [Go] language.

To use as an executable binary the following options are available:

```
$ make
$ make run
$ make install
$ make uninstall
```

To use as a Docker container the following options are available:

```
$ make docker-build
$ make docker-push
$ make docker-run
```

## Usage

```
Usage: pause
       pause version
```

<!-- Links -->

[Go]: https://golang.org
