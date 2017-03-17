Protobuf JSON Runtime for BuckleScript
--------------------------------------

> This package provide the runtime library in BuckleScript (OCaml) to be used
> generated code from [ocaml-protoc](https://github.com/mransan/ocaml-protoc/). 

Getting Started
---------------

#### Prerequesite

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

**[bucklescript](https://github.com/bloomberg/bucklescript)**

> BuckleScript is the OCaml to JavaScript transpiler 

If not installed you can install it running the following
```bash
npm install bs-platform
``` 

#### Installation

To install the JSON runtime:
```bash
npm install bs-ocaml-protoc-json
```
or 
```bash 
yarn add bs-ocaml-protoc-json
```

#### Simple example 

> In this simple example we'll demonstrate how to implement a library in OCaml
> to perform temperature conversion API. 
>
> The library API interface will be in JSON.

> We assume you start in an empty directory 


Start by creating the src directory:
```bash
mkdir src
```

**Define a protobuf message** 

Create a `src/messages.proto` file with the following content:

```Protobuf
syntax = "proto3";

enum Unit  {
  CELCIUS = 0; 
  FAHRENHEIT = 1;
}

message Temperature {
  Unit unit = 1; 
  float value =  2;
}

message Request {
  Unit desired_unit = 1;
  Temperature temperature = 2; 
}

message Response {
  oneof t {
    string error = 1; 
    Temperature temperature = 2;
  }
}
```
