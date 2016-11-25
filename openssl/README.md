# openssl

Windows Nano Server image with [OpenSSL](https://www.openssl.org/) installed.

# Usage

E.g. to generate a [self-signed certificate for a local Docker registry](https://docs.docker.com/registry/insecure/#/using-self-signed-certificates):

```PowerShell
mkdir certs

docker run -it -v $pwd\certs:c:\certs sixeyed/openssl:nanoserver `
 req -newkey rsa:4096 -nodes -sha256 -x509 -days 365 `
 -out c:\certs registry.local.crt `
 -keyout c:\certs\registry.local.key `
 -subj '/CN=registry.local/O=myorg/C=GB'
```

That will generate `registry.local.crt` and `registry.local.key` files in the `certs` subdirectory on the host.

You can double-click the `.crt` file and install the certificate into your local trusted store.