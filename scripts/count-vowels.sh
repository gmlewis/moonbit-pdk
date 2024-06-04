#!/bin/bash -e
extism call target/wasm-gc/release/build/examples/count-vowels/count-vowels.wasm count_vowels --wasi --input "$@"
