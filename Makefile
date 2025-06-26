source_dir := $(CURDIR)
ENV_NAME = env
PYTHON_COMMAND ?= python3
make_env = $(PYTHON_COMMAND) -m venv $(ENV_NAME)
env_dir = $(CURDIR)/$(ENV_NAME)
bin_dir = $(env_dir)/bin
activate_env = . $(bin_dir)/activate

SETTINGS_FILE ?= core.settings
DJANGO_APP ?=
MIGRATION_NAME ?=

define create-env
	@echo Creating $@...
	$(make_env)
	$(bin_dir)/pip install --upgrade pip
endef

define clear-python-cache
	@echo Clearing Eskom project...
	rm -rf dist
	rm -rf static
	rm -rf $(env_dir)
	rm -rf node_modules
	rm -rf `find . -type d -name ".cache"`
	rm -rf `find . -type d -name "__pycache__"`
	rm -rf `find . -type f -name "*.py[co]"`
	rm -rf `find . -type d -name "*.egg-info"`
	rm -rf `find . -type d -name "pip-wheel-metadata"`
	deactivate
endef

.PHONY: all
all: install

env:
	$(create-env)

.PHONY: install
install: env
	@echo Installing frontend packages...
	yarn

	@echo Installing backend packages...
	$(bin_dir)/pip install -r requirements.txt

	@echo Project is ready...


.PHONY: freeze
freeze:
	$(bin_dir)/pip freeze > requirements.txt

.PHONY: migrate
migrate:
	$(bin_dir)/$(PYTHON_COMMAND) manage.py migrate --settings=$(SETTINGS_FILE) $(DJANGO_APP) $(MIGRATION_NAME)

.PHONY: migrations
migrations:
	$(bin_dir)/$(PYTHON_COMMAND) manage.py makemigrations --settings=$(SETTINGS_FILE)

.PHONY: superuser
superuser:
	$(bin_dir)/$(PYTHON_COMMAND) manage.py createsuperuser --settings=$(SETTINGS_FILE)

.PHONY: dev
dev:
	$(bin_dir)/$(PYTHON_COMMAND) manage.py runserver --settings=$(SETTINGS_FILE)

.PHONY: lint
lint:
	$(bin_dir)/flake8 $(source_dir)

.PHONY: format
format:
	yarn prettier --write src/
	$(bin_dir)/black $(source_dir)

.PHONY: clean
clean:
	$(clear-python-cache)
