KBase Service Template
================

Provide the service template for using AWE, Shock, Workspace together to integrate personal script into a new service


How to use it
================
1. git clone https://github.com/sjyoo/service_template; cd service_template
2. make
3. start services
  - . /kb/deployment/user-env.sh; mkdir -p /mnt/mongo; mongod --dbpath=/mnt/mongo
  - /kb/deployment/services/shock_service/start_service
  - /kb/deployment/services/awe_service/start_service
  - /kb/deployment/services/userandjobstate/start_service
  - /kb/deployment/services/workspace/start_service
4. Add your code into repo
  - cd /kb/dev_container/modules/MyService/
  - git init
  - git add *
  - git commit -m "first commit"
  - git remote add origin https://github.com/kbase/your_repo_name.git
  - git push -u origin master
