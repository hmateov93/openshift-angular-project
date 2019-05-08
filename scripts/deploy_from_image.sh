oc login https://console.starter-us-west-2.openshift.com/
docker login registry.starter-us-west-2.openshift.com -u $(oc whoami) -p $(oc whoami -t)
docker image prune -f
docker build -t registry.starter-us-west-2.openshift.com/tutorial-openshift/openshift-angular-project .
docker push registry.starter-us-west-2.openshift.com/tutorial-openshift/openshift-angular-project
