DATELONG = $(shell date +'%Y-%m-%d')
NAME = unamed

new:
	touch _posts/$(DATELONG)-$(NAME).emu
	echo -e "|>Metadata\n    title = $(NAME)\n    tags =" > _posts/$(DATELONG)-$(NAME).emu
	git add _posts/$(DATELONG)-$(NAME).emu


build:
	echo "builing "
	~/.yarn/bin/elmstatic build

watch:
	echo "watching"
	~/.yarn/bin/elmstatic watch &
	(cd docs; ~/.yarn/bin/browser-sync start --server --files "." --no-ui  --reload-delay 500 --reload-debounce 500)

commit:
	git add -A
	git commit -m "new entries "$(date +'%m-%d-%y')

push: build commit
	git push origin master
