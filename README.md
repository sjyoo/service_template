KBase Service Template
================

Provide the service template for using AWE, Shock, Workspace together to integrate personal script into a new service


How to use it
================
1. git clone https://github.com/sjyoo/service_template; cd service_template
2. Set environment variables
  - export SERVICE_NAME=MyNewService
  - export SERVICE_PORT=9999 (Register at https://trac.kbase.us/projects/kbase/wiki/IntegrationTargets)
3. make
4. start services
  - . /kb/deployment/user-env.sh; mkdir -p /mnt/mongo; mongod --dbpath=/mnt/mongo
  - /kb/deployment/services/shock_service/start_service
  - /kb/deployment/services/awe_service/start_service
  - /kb/deployment/services/userandjobstate/start_service
  - /kb/deployment/services/workspace/start_service
5. Add your scripts in your /kb/dev_container/modules/$SERVICE_NAME/scripts and update configurations
6. Add your code into repo
  - cd /kb/dev_container/modules/$SERVICE_NAME/
  - git init
  - git add *
  - git commit -m "first commit"
  - git remote add origin https://github.com/kbase/your_repo_name.git
  - git push -u origin master
