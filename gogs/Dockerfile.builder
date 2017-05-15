# escape=`
FROM golang:1.8-windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

CMD go get -u -tags \"sqlite pam cert\" github.com/gogits/gogs; `
    cd "$env:GOPATH\\src\\github.com\\gogits\\gogs"; `
    go build -tags \"sqlite pam cert\"; `
    cp -r . c:\out\