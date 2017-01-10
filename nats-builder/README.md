# NATS builder

Windows Docker images which build [NATS](http://nats.io/) from source and run tests. For verifying functionality on Windows Server Core and Nano Server.


## Windows Server Core

The image downloads the lastest source and runs tests:

```
> docker run --rm --publish-all sixeyed/nats-builder:windowsservercore
?       github.com/nats-io/gnatsd       [no test files]
?       github.com/nats-io/gnatsd/auth  [no test files]
ok      github.com/nats-io/gnatsd/conf  0.031s
ok      github.com/nats-io/gnatsd/logger        0.735s
ok      github.com/nats-io/gnatsd/server        99.523s
ok      github.com/nats-io/gnatsd/server/pse    1.691s
ok      github.com/nats-io/gnatsd/test  222.418s
?       github.com/nats-io/gnatsd/util  [no test files]
?       github.com/nats-io/gnatsd/vendor/github.com/nats-io/nuid        [no test files]
?       github.com/nats-io/gnatsd/vendor/golang.org/x/crypto/bcrypt     [no test files]
?       github.com/nats-io/gnatsd/vendor/golang.org/x/crypto/blowfish   [no test files]
```

## Nano Server

Slightly more involved - `go get` fails on Nano Server with a Git submodule issue which I haven't tracked down. To get around that we use a Windows Server Core container to get the source into a Docker volume, and then use the same volume in the Nano Server container to build and test the source:

```
> docker volume create nats-source
nats-source

> docker run --rm -v nats-source:c:\src sixeyed/nats-sourceloader

> docker run --rm -v nats-source:c:\src --publish-all sixeyed/nats-builder:nanoserver
?       github.com/nats-io/gnatsd       [no test files]
?       github.com/nats-io/gnatsd/auth  [no test files]
ok      github.com/nats-io/gnatsd/conf  0.032s
ok      github.com/nats-io/gnatsd/logger        0.259s
ok      github.com/nats-io/gnatsd/server        95.867s
ok      github.com/nats-io/gnatsd/server/pse    1.576s
ok      github.com/nats-io/gnatsd/test  220.703s
?       github.com/nats-io/gnatsd/util  [no test files]
?       github.com/nats-io/gnatsd/vendor/github.com/nats-io/nuid        [no test files]
?       github.com/nats-io/gnatsd/vendor/golang.org/x/crypto/bcrypt     [no test files]
?       github.com/nats-io/gnatsd/vendor/golang.org/x/crypto/blowfish   [no test files]
```
