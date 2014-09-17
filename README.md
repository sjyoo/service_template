KBase Service Template
================

The KBase service template repo provides a new service code template using AWE, Shock, Workspace and your personal scripts.


How to set up
----------------
1. git clone https://github.com/sjyoo/service_template; cd service_template
2. Set environment variables
  - export SERVICE_NAME=MyNewService
  - export SERVICE_PORT=9999 (Register at https://trac.kbase.us/projects/kbase/wiki/IntegrationTargets)
3. make
4. start services
  - . /kb/deployment/user-env.sh; mkdir -p /mnt/mongo; mongod --dbpath=/mnt/mongo
  - /kb/deployment/services/workspace/start_service
  - /kb/deployment/services/shock_service/start_service
  - /kb/deployment/services/awe_service/start_service
  - /kb/deployment/services/awe_service/start_aweclient
  - /kb/deployment/services/userandjobstate/start_service
5. Add your scripts in your /kb/dev_container/modules/$SERVICE_NAME/scripts and update your script configurations (refer Service Configuration)
6. Add your code into repo
  - cd /kb/dev_container/modules/$SERVICE_NAME/
  - git init
  - git add *
  - git commit -m "first commit"
  - git remote add origin https://github.com/kbase/your_repo_name.git
  - git push -u origin master

How to configure your scripts
----------------
Will add a google doc later
