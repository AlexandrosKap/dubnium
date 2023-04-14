// Copyright (c) 2023 Alexandros Filippos Giounior Kapretsos
// Distributed under the MIT License, see LICENSE file.

import core.stdc.stdlib : exit;
import std.file : SpanMode, dirEntries, getcwd, exists, isDir;
import std.format : format;
import std.path : baseName, buildPath;
import std.process : spawnShell, wait;
import std.stdio : writeln;

/// Gets the entries of the given directory path.
auto getEntries(string path) {
    return dirEntries(path, SpanMode.shallow);
}

/// Returns true if the given directory path has a dub package.
bool isDubPackage(string path) {
    foreach (entry; getEntries(path)) {
        if (baseName(entry) == "dub.json")
            return true;
    }
    return false;
}

/// Returns true if the given directory path has an examples directory.
bool hasExamples(string path) {
    auto examples = buildPath(path, "examples");
    return exists(examples) && isDir(examples);
}

/// Runs a command and exits if something failed.
void run(string cmd) {
    if (wait(spawnShell(cmd)) == 0) {
        writeln(format("[INFO] success: %s", cmd));
    } else {
        writeln(format("[INFO] failure: %s", cmd));
        exit(1);
    }
}

/// Runs a DUB command and exits if something failed.
void runDubCmd(string path, string cmd) {
    run(format("dub --root=%s %s", path, cmd));
}

/// Runs the tests of the given dub package.
void runTests(string path) {
    runDubCmd(path, "test");
}

/// Runs the examples of the given dub package.
void runExamples(string path) {
    if (hasExamples(path)) {
        foreach (entry; getEntries(buildPath(path, "examples"))) {
            if (isDubPackage(entry))
                runDubCmd(entry, "run");
        }
    }
}

void main(string[] args) {
    auto dir = (args.length > 1) ? args[1] : getcwd();
    if (isDubPackage(dir)) {
        runTests(dir);
        runExamples(dir);
    } else {
        writeln(format("Path '%s' is not a dub package.", dir));
    }
}
