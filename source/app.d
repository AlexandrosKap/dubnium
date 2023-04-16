// Copyright (c) 2023 Alexandros Filippos Giounior Kapretsos
// Distributed under the MIT License, see LICENSE file.

import std.file;
import std.format;
import std.path;
import std.process;
import std.stdio;

/// Returns true if the given directory path has a dub package.
bool isDubPackage(string path) {
    foreach (entry; dirEntries(path, SpanMode.shallow)) {
        if (baseName(entry) == "dub.json") {
            return true;
        }
    }
    return false;
}

/// Returns true if the given directory path has an examples directory.
bool hasExamples(string path) {
    auto examples = buildPath(path, "examples");
    return exists(examples) && isDir(examples);
}

/// Runs the examples of the given dub package.
int runExamples(string path) {
    foreach (entry; dirEntries(buildPath(path, "examples"), SpanMode.shallow)) {
        if (isDubPackage(entry)) {
            Pid pid = spawnShell(format("dub --root=%s run", entry));
            int status = wait(pid) != 0;
            if (status != 0) {
                return status;
            }
        }
    }
    return 0;
}

int main(string[] args) {
    auto dir = (args.length > 1) ? args[1] : getcwd();
    if (isDubPackage(dir) && hasExamples(dir)) {
        return runExamples(dir);
    } else {
        writeln(format("Path '%s' is not a DUB package with examples.", dir));
        return 1;
    }
}
