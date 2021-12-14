~/.yarn/bin/elmstatic watch &
(cd docs;
~/.yarn/bin/browser-sync start --server --files "." --no-ui  --reload-delay 500 --reload-debounce 500)
