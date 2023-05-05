all: ima README.md CONTRIBUTING.md README.txt youtube-dl.1 youtube-dl.bash-completion youtube-dl.zsh youtube-dl.fish supportedsites

clean:
	rm -rf ima man/ima.1 build/ dist/ .coverage cover/ ima.tar.gz
	find . -name "*.pyc" -delete
	find . -name "*.class" -delete

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/man
SHAREDIR ?= $(PREFIX)/share
PYTHON ?= /usr/bin/env python

# set SYSCONFDIR to /etc if PREFIX=/usr or PREFIX=/usr/local
SYSCONFDIR = $(shell if [ $(PREFIX) = /usr -o $(PREFIX) = /usr/local ]; then echo /etc; else echo $(PREFIX)/etc; fi)

install: ima ima.1 ima.bash-completion ima.zsh ima.fish
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 ima $(DESTDIR)$(BINDIR)
	install -d $(DESTDIR)$(MANDIR)/man1
	install -m 644 man/ima.1 $(DESTDIR)$(MANDIR)/man1
	#install -d $(DESTDIR)$(SYSCONFDIR)/bash_completion.d
	#install -m 644 auto-completions/ima.bash-completion $(DESTDIR)$(SYSCONFDIR)/bash_completion.d/ima
	#install -d $(DESTDIR)$(SHAREDIR)/zsh/site-functions
	#install -m 644 auto-completions/ima.zsh $(DESTDIR)$(SHAREDIR)/zsh/site-functions/_ima
	#install -d $(DESTDIR)$(SYSCONFDIR)/fish/completions
	#install -m 644 ima.fish $(DESTDIR)$(SYSCONFDIR)/fish/completions/ima.fish

test:
	pytest

tar: ima.tar.gz

.PHONY: all clean install test tar

#bash-completion pypi-files zsh-completion fish-completion ot offlinetest codetest supportedsites

pypi-files: youtube-dl.bash-completion README.txt youtube-dl.1 youtube-dl.fish

youtube-dl: src/*.py
	mkdir -p zip
	for d in youtube_dl youtube_dl/downloader youtube_dl/extractor youtube_dl/postprocessor ; do \
	  mkdir -p zip/$$d ;\
	  cp -pPR $$d/*.py zip/$$d/ ;\
	done
	touch -t 200001010101 zip/*.py
	mv zip/youtube_dl/__main__.py zip/
	cd zip ; zip -q ../youtube-dl youtube_dl/*.py youtube_dl/*/*.py __main__.py
	rm -rf zip
	echo '#!$(PYTHON)' > youtube-dl
	cat youtube-dl.zip >> youtube-dl
	rm youtube-dl.zip
	chmod a+x youtube-dl

README.md: youtube_dl/*.py youtube_dl/*/*.py
	COLUMNS=80 $(PYTHON) youtube_dl/__main__.py --help | $(PYTHON) devscripts/make_readme.py

youtube-dl.1: README.md
	pandoc -s -f $(MARKDOWN) -t man youtube-dl.1.temp.md -o youtube-dl.1
	rm -f ima.1.temp.md

youtube-dl.bash-completion: youtube_dl/*.py youtube_dl/*/*.py devscripts/bash-completion.in
	$(PYTHON) devscripts/bash-completion.py

bash-completion: youtube-dl.bash-completion

youtube-dl.zsh: youtube_dl/*.py youtube_dl/*/*.py devscripts/zsh-completion.in
	$(PYTHON) devscripts/zsh-completion.py

zsh-completion: youtube-dl.zsh

youtube-dl.fish: youtube_dl/*.py youtube_dl/*/*.py devscripts/fish-completion.in
	$(PYTHON) devscripts/fish-completion.py

fish-completion: youtube-dl.fish

lazy-extractors: youtube_dl/extractor/lazy_extractors.py

_EXTRACTOR_FILES = $(shell find youtube_dl/extractor -iname '*.py' -and -not -iname 'lazy_extractors.py')
youtube_dl/extractor/lazy_extractors.py: devscripts/make_lazy_extractors.py devscripts/lazy_load_template.py $(_EXTRACTOR_FILES)
	$(PYTHON) devscripts/make_lazy_extractors.py $@

youtube-dl.tar.gz: youtube-dl README.md README.txt youtube-dl.1 youtube-dl.bash-completion youtube-dl.zsh youtube-dl.fish ChangeLog AUTHORS
	@tar -czf youtube-dl.tar.gz --transform "s|^|youtube-dl/|" --owner 0 --group 0 \
		--exclude '*.DS_Store' \
		--exclude '*.kate-swp' \
		--exclude '*.pyc' \
		--exclude '*.pyo' \
		--exclude '*~' \
		--exclude '__pycache__' \
		--exclude '.git' \
		--exclude 'docs/_build' \
		-- \
		bin devscripts test youtube_dl docs \
		ChangeLog AUTHORS LICENSE README.md README.txt \
		Makefile MANIFEST.in youtube-dl.1 youtube-dl.bash-completion \
		youtube-dl.zsh youtube-dl.fish setup.py setup.cfg \
		youtube-dl
