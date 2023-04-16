# Dubnium

An example runner for DUB packages.
It runs all the available examples of a package.

## Usage

The examples of a package should be in a directory named 'examples'
and each example should be its own DUB package.
To run the examples in the current directory, run the following command:

```sh
dubnium
```
To run the examples in another directory, run the following command:

```sh
dubnium my/cute/package
```

## Why

Testing the examples of a package can be a tedious process.
This program makes that process a little easier.
That's it... Or is it?

## Installation

Clone the repo and run the following command:

```sh
dub build -b release
```

That's it.
You can now add the generated executable to your path.

## License

The project is released under the terms of the MIT License.
Please refer to the LICENSE file.
