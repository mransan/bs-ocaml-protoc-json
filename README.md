Protobuf JSON Runtime for BuckleScript
--------------------------------------

> This package provide the runtime library in BuckleScript to be used with 
> generated code from [ocaml-protoc](https://github.com/mransan/ocaml-protoc/). 

Installation - Prerequesites
----------------------------

**[opam](http://opam.ocaml.org/)** 

> opam is the package manager for OCaml 

If not installed you can install it running the following:
```bash 
wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh -O - | \
  sh -s /usr/local/bin 4.02.3+buckle-master
eval `opam config env` 
``` 

**[ocaml-protoc](https://github.com/mransan/ocaml-protoc)**

> `ocaml-protoc` is the compiler for protobuf messages to OCaml

```bash
opam install --yes ocaml-protoc
```

**[npm](https://nodejs.org/en/download/current/)**

> We assume you have node installed!

Simple example 
--------------

For a simple example see [here](https://github.com/mransan/bs-protobuf-demo).
