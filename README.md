# tanh.xyz

## Description
Source code of tanh.xyz, a blog by cwhy

## Init
yarn global add elmstatic browser-sync

## Build
./build.sh

## Watch
term 1
```bash
~/.yarn/bin/elmstatic watch
```

term 2
```bash
cd docs
~/.yarn/bin/browser-sync start --server --files "." --no-ui  --reload-delay 500 --reload-debounce 500
```
