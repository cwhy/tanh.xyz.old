build:
	~/.yarn/bin/elmstatic build
watch:
	~/.yarn/bin/elmstatic watch &
	(cd docs; ~/.yarn/bin/browser-sync start --server --files "." --no-ui  --reload-delay 500 --reload-debounce 500)

commit:
	git add -A
	git commit -m "new entries "$(date +'%m-%d-%y')

push: build commit
	git push origin master
