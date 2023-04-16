// Copyright (c) 2023 Alexandros Filippos Giounior Kapretsos
// Distributed under the MIT License, see LICENSE file.

import std.file : getcwd;
import std.format : format;
import std.stdio : writeln;

import dubnium;

int main(string[] args) {
    auto dir = (args.length > 1) ? args[1] : getcwd();
    if (isDubPackage(dir)) {
        writeln("Dubnium go brrr...");
        runTests(dir);
        runExamples(dir);
        return 0;
    } else {
        writeln(format("Path '%s' is not a DUB package.", dir));
        return 1;
    }
}
