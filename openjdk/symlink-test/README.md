
# SymLinkTest

Simple test to replicate an issue accessing symlink directories in Windows Containers using OpenJDK (and probably Java too).

This may be the same issue that affected Go on Windows ([fixed in version 1.8](https://github.com/golang/go/issues/15978#issuecomment-224387894)).  

The issue looks like an edge case, but this is the mechanism that Docker uses on Windows to store data outside of a container. Without a fix it basically means you can't use Java apps in Windows Docker containers and store data persistently in a [Docker volume](https://docs.docker.com/engine/tutorials/dockervolumes/).

## Issue

Class `java.nio.file.Path`, method `toRealPath` has the logic to find the real path for a symlink directory. It doesn't support the symlink that maps a volume in a Docker container.

## Reproduction 

Using the `SymLinkTest.java` sample, this is easy to test. On Windows you can create a directory and a symlink to it and `toRealPath` works correctly:

```
>mkdir real-directory
>mklink /D symlink-directory real-directory
symbolic link created for symlink-directory <<===>> real-directory

>java -cp . SymLinkTest real-directory
Path: real-directory
toRealPath: C:\scm\github\sixeyed\dockers-windows\openjdk\symlink-test\real-directory

>java -cp . SymLinkTest symlink-directory
Path: symlink-directory
toRealPath: C:\scm\github\sixeyed\dockers-windows\openjdk\symlink-test\real-directory
```

In a Docker container, the symlink syntax causes `toRealPath` to fail. You will need [Docker running on Windows 10 or Server 2016](https://github.com/docker/labs/tree/master/windows/windows-containers) to repro this.

```
>docker run -it --rm sixeyed/openjdk-symlinktest
...
>java -cp . SymLinkTest c:\volume-directory
Path: c:\volume-directory
Exception in thread "main" java.nio.file.NoSuchFileException: c:\volume-directory
        at sun.nio.fs.WindowsException.translateToIOException(WindowsException.java:79)
        at sun.nio.fs.WindowsException.rethrowAsIOException(WindowsException.java:97)
        at sun.nio.fs.WindowsException.rethrowAsIOException(WindowsException.java:102)
        at sun.nio.fs.WindowsLinkSupport.getFinalPath(WindowsLinkSupport.java:82)
        at sun.nio.fs.WindowsLinkSupport.getRealPath(WindowsLinkSupport.java:242)
        at sun.nio.fs.WindowsPath.toRealPath(WindowsPath.java:836)
        at sun.nio.fs.WindowsPath.toRealPath(WindowsPath.java:44)
        at SymLinkTest.main(symlinkd-test.java:9)
```

The directory exists:

```
>dir c:\
...
01/09/2017  08:02 AM    <SYMLINKD>     volume-directory [\\?\ContainerMappedDirectories\01BA2580-95DA-48B9-94F2-B397D00CD0A1]
```

And it is a valid reparse point:

```
>fsutil reparsepoint query c:\volume-directory
Reparse Tag Value : 0xa000000c
Tag value: Microsoft
Tag value: Name Surrogate
Tag value: Symbolic Link

Reparse Data Length: 0x00000116
Reparse Data:
0000:  00 00 80 00 82 00 86 00  00 00 00 00 5c 00 43 00  ............\.C.
0010:  6f 00 6e 00 74 00 61 00  69 00 6e 00 65 00 72 00  o.n.t.a.i.n.e.r.
0020:  4d 00 61 00 70 00 70 00  65 00 64 00 44 00 69 00  M.a.p.p.e.d.D.i.
0030:  72 00 65 00 63 00 74 00  6f 00 72 00 69 00 65 00  r.e.c.t.o.r.i.e.
0040:  73 00 5c 00 30 00 31 00  42 00 41 00 32 00 35 00  s.\.0.1.B.A.2.5.
0050:  38 00 30 00 2d 00 39 00  35 00 44 00 41 00 2d 00  8.0.-.9.5.D.A.-.
0060:  34 00 38 00 42 00 39 00  2d 00 39 00 34 00 46 00  4.8.B.9.-.9.4.F.
0070:  32 00 2d 00 42 00 33 00  39 00 37 00 44 00 30 00  2.-.B.3.9.7.D.0.
0080:  30 00 43 00 44 00 30 00  41 00 31 00 00 00 5c 00  0.C.D.0.A.1...\.
0090:  5c 00 3f 00 5c 00 43 00  6f 00 6e 00 74 00 61 00  \.?.\.C.o.n.t.a.
00a0:  69 00 6e 00 65 00 72 00  4d 00 61 00 70 00 70 00  i.n.e.r.M.a.p.p.
00b0:  65 00 64 00 44 00 69 00  72 00 65 00 63 00 74 00  e.d.D.i.r.e.c.t.
00c0:  6f 00 72 00 69 00 65 00  73 00 5c 00 30 00 31 00  o.r.i.e.s.\.0.1.
00d0:  42 00 41 00 32 00 35 00  38 00 30 00 2d 00 39 00  B.A.2.5.8.0.-.9.
00e0:  35 00 44 00 41 00 2d 00  34 00 38 00 42 00 39 00  5.D.A.-.4.8.B.9.
00f0:  2d 00 39 00 34 00 46 00  32 00 2d 00 42 00 33 00  -.9.4.F.2.-.B.3.
0100:  39 00 37 00 44 00 30 00  30 00 43 00 44 00 30 00  9.7.D.0.0.C.D.0.
0110:  41 00 31 00 00 00                                 A.1...
```
