fmt:
	terraform fmt -recursive

fmt-check:
	terraform fmt -recursive -check

setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)

tf-init-backend:
ifndef PASSWORD
	$(error PASSWORD is undefined)
endif
	terraform init -backend-config="conn_str=postgres://postgres:${PASSWORD}@127.0.0.1:15432/postgres?sslmode=disable"
