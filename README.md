# Pause

An executable that waits for any of SIGTERM, SIGINT or SIGCHLD signals and
exits. It could wait for any of these signals specified number of times.

## Build

Build process requires the [Go] language.

To use as an executable:

```
$ make
$ make run
$ make install
$ make uninstall
```

```
Usage: pause [version] [--number N]
```

To use as a Docker container:

```
$ make docker-build
$ make docker-run
$ make docker-push
```

<!-- Links -->

[Go]: https://golang.org
