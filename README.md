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
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/actions-matrix/alpine-matrix-action/assets/4363857/8cf23a35-1d51-491d-b897-d4fbc1a51a61">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/actions-matrix/alpine-matrix-action/assets/4363857/1b5fa538-b6f5-45d0-bb79-4c7447b4a179">
  <img alt="Screenshot" src="https://github.com/actions-matrix/alpine-matrix-action/assets/4363857/1b5fa538-b6f5-45d0-bb79-4c7447b4a179">
</picture>

## License

Licensed under [MIT license](LICENSE).
