# alpine-matrix-action
GitHub Action to generate Alpine releases matrix

## Usage

```yaml
name: Test

on:
  push:
    branches:
      - main

jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - id: alpine
        uses: actions-matrix/alpine-matrix-action@v1
    outputs:
      alpine: ${{ steps.alpine.outputs.matrix }}

  build:
    runs-on: ubuntu-latest
    needs: generate
    strategy:
      matrix: ${{ fromJson(needs.generate.outputs.alpine) }}
    steps:
      - run: echo "Build ${{ matrix.os }} ${{ matrix.version }}"
```
