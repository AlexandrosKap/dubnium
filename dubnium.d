// Copyright (c) 2023 Alexandros Filippos Giounior Kapretsos
// Distributed under the MIT License, see LICENSE file.

import core.stdc.stdlib : exit;
import std;

/// Gets the entries of the given directory path.
auto getEntries(string path) {
    return dirEntries(path, SpanMode.shallow);
}

/// Returns true if the given directory path has a dub package.
bool isDubPackage(string path) {
    foreach (entry; getEntries(path)) {
        if (baseName(entry) == "dub.json") return true;
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
    if (wait(spawnShell(cmd)) != 0) exit(1);
}

/// Runs the tests of the given dub package.
void runTests(string path) {
    run(format("dub --root=%s test", path));
}

/// Runs the examples of the given dub package.
void runExamples(string path) {
    foreach (entry; getEntries(buildPath(path, "examples"))) {
        run(format("dub --root=%s build", entry));
        run(format(buildPath(entry, baseName(entry))));
    }
}

void main(string[] args) {
    auto dir = (args.length > 1) ? args[1] : getcwd();
    if (isDubPackage(dir)) {
        runTests(dir);
        if (hasExamples(dir)) runExamples(dir);
    } else {
        writeln(format("Path '%s' is not a dub package.", dir));
    }
}
