# Dubnium

A helper program for DUB packages.
Currently, it only runs all the available tests and examples of a package.

## Usage

The examples of a package should be in a directory named 'examples'
and each example should be its own DUB package.

To test the package in the current directory, run the following command:

```sh
dubnium
```

To test a package in another directory, run the following command:

```sh
dubnium my/cute/dir
```

## Why

Testing the examples of a package can be tidius.
This program makes the testing experience a little easier by avoiding cd this and cd that.
That's it... Or is it?

## Installation

Clone the repo and run the following command:

```sh
dmd dubnium.d
```

That's it.
You can add the generated executable to your path.

## License

The project is released under the terms of the MIT License.
Please refer to the LICENSE file.
