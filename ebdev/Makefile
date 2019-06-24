.PHONY: post

sync:
	rsync -auv "$$FASRCSW_DEV"/ebdev/SOURCES/ "$$FASRCSW_PROD"/SOURCES/

post: sync
	cd "$$FASRCSW_DEV"
	git add --all .
	git commit -v .
	git pull
	git push
