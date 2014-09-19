TOP_DIR ?= /kb/dev_container
DEPLOY_RUNTIME ?= /kb/runtime
TARGET ?= /kb/deployment
SERVICE_NAME ?= MyService
SERVICE_PORT ?= 9999
SERVICE_DIR = $(TOP_DIR)/modules/$(SERVICE_NAME)

TPAGE = $(DEPLOY_RUNTIME)/bin/tpage
TPAGE_ARGS = --define kb_top=$(TARGET) --define kb_runtime=$(DEPLOY_RUNTIME) --define kb_service_name=$(SERVICE_NAME) --define kb_service_port=$(SERVICE_PORT)

TT_FILES = $(wildcard *.tt)
TTT_FILES = $(wildcard t/*.tt)
default: dev_container deploy

dev_container:
	if [ ! -d $(TOP_DIR) ] ; then git clone https://github.com/kbase/dev_container $(TOP_DIR) ; fi
	if [ ! -d $(TOP_DIR)/modules/kbwf_common ] ; then git clone https://github.com/sjyoo/kbwf_common $(TOP_DIR)/modules/kbwf_common ; fi
	if [ ! -d $(TOP_DIR)/modules/typecomp ] ; then git clone https://github.com/kbase/typecomp $(TOP_DIR)/modules/typecomp ; fi
	if [ ! -d $(TOP_DIR)/modules/user_and_job_state ] ; then git clone https://github.com/kbase/user_and_job_state $(TOP_DIR)/modules/user_and_job_state ; fi
	if [ ! -d $(TOP_DIR)/modules/workspace_deluxe ] ; then git clone https://github.com/kbase/workspace_deluxe $(TOP_DIR)/modules/workspace_deluxe ; fi
	if [ ! -d $(TOP_DIR)/modules/handle_service ] ; then git clone https://github.com/kbase/handle_service $(TOP_DIR)/modules/handle_service ; fi
	if [ ! -d $(TOP_DIR)/modules/handle_mngr ] ; then git clone https://github.com/kbase/handle_mngr $(TOP_DIR)/modules/handle_mngr ; fi
	if [ ! -d $(TOP_DIR)/modules/awe_service ] ; then git clone https://github.com/kbase/awe_service $(TOP_DIR)/modules/awe_service ; fi
	if [ ! -d $(TOP_DIR)/modules/shock_service ] ; then git clone https://github.com/kbase/shock_service $(TOP_DIR)/modules/shock_service ; fi
	if [ ! -d $(TOP_DIR)/modules/kbapi_common ] ; then git clone https://github.com/kbase/kbapi_common $(TOP_DIR)/modules/kbapi_common ; fi
	if [ ! -d $(TOP_DIR)/modules/jars ] ; then git clone https://github.com/kbase/jars $(TOP_DIR)/modules/jars ; fi
	if [ ! -d $(TOP_DIR)/modules/auth ] ; then git clone kbase@git.kbase.us:auth $(TOP_DIR)/modules/auth ; fi
	#cd $(TOP_DIR); $(TOP_DIR)/bootstrap $(DEPLOY_RUNTIME);

deploy: deploy_repo deploy_make deploy_config

deploy_make:
	cd $(TOP_DIR); $(TOP_DIR)/bootstrap $(DEPLOY_RUNTIME); . $(TOP_DIR)/user-env.sh; make; make deploy

deploy_repo: 
	if [ ! -d $(SERVICE_DIR) ] ; then \
        	mkdir -p $(SERVICE_DIR) ; \
        	rsync --exclude '*.tt' --exclude lconfig --exclude ".git" -arv . $(SERVICE_DIR); \
        	cp -r service $(SERVICE_DIR); \
		for src in $(TT_FILES) ; do \
			basefile=`basename $$src`; \
			base=`basename $$src .tt`; \
			$(TPAGE) $(TPAGE_ARGS) $$src > $(SERVICE_DIR)/$$base; \
		done; \
		for src in $(TTT_FILES) ; do \
			basefile=`basename $$src`; \
			base=`basename $$src .tt`; \
			$(TPAGE) $(TPAGE_ARGS) $$src > $(SERVICE_DIR)/t/$$base; \
		done; \
		mv $(SERVICE_DIR)/MyService.spec $(SERVICE_DIR)/$(SERVICE_NAME).spec; \
	fi

deploy_config:
	cp lconfig/deployment.cfg $(TARGET)
	cp lconfig/awe/* $(TARGET)/services/awe_service/conf
	cp lconfig/shock/* $(TARGET)/services/shock_service/conf
	cp lconfig/ws/* $(TARGET)/services/workspace
	cp lconfig/ujs/* $(TARGET)/services/userandjobstate
	mkdir -p /mnt/Shock/logs
	mkdir -p /mnt/Shock/site
	mkdir -p /mnt/Shock/data

clean:
	rm -rf $(TOP_DIR) $(TARGET)
