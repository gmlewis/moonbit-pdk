#!/bin/bash -e
git checkout main
rep 'gmlewis/moonbit' 'extism/moonbit' diffs
patch -p1 < diffs
