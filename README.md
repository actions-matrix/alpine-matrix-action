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
      matrix: ${{ steps.alpine.outputs.matrix }}

  build:
    runs-on: ubuntu-latest
    needs: generate
    strategy:
      matrix: ${{ fromJson(needs.generate.outputs.matrix) }}
    steps:
      - run: echo "Build ${{ matrix.os }} ${{ matrix.version }}"
```
**Example**

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/actions-matrix/alpine-matrix-action/assets/4363857/717856f8-1656-41a1-836b-13955d27f1ee">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/actions-matrix/alpine-matrix-action/assets/4363857/4f344d14-7d99-4e2a-baa2-9312cb4f3b7d">
  <img alt="Screenshot" src="https://github.com/actions-matrix/alpine-matrix-action/assets/4363857/717856f8-1656-41a1-836b-13955d27f1ee">
</picture>
