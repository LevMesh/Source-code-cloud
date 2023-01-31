# Intro

Hey there! 
My name is Lev Meshorer, a Junior DevOps Engineer.

# Project Description
Overview diagnose on the task:

Create a CI/CD pipeline that deploys a "product" cluster with updated docker image with several features such as Trivy to scan for vunrabilities in your docker image, datree to scan the helm chart and Polaris dashboard for monitoring.

# Repo Usage

In the root directory we have our Jenkinsfile and in java-maven-app directory we have the Dockerfile and the source code.

1. Enter Jenkins-cloud directory change the in main.tf file to your key pair location, ami-id and aws region.

1. Enter Jenkins-cloud directory and run ```terraform init``` and ```terraform apply```.

2. After your ec2-jenkins-server is deployed go and enter its terminal and run the following commands: 
    A) ssh-keygen ###NOTE### In the save location path enter: /var/lib/jenkins/.ssh and give them permissions in needed.
    B) ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
    C) Get the jenkins defualt password with: cat /var/lib/jenkins/secrets/initialAdminPassword
    D) Add your public ssh key into your github repository (or you can clone mine with https).
    
3. Once you got your admin password - enter the jenkins server in the gui, create a pipeline job and add the repository.

4. Edit the pipeline section of the publish to docker hub to match your case (adding your own credentials and edit the jenkinsfile). 

5. Run and Enjoy!

### Important note ###

You might have some errors in the pipeline saying jenkins doesn't know some commands, in order to fix it you need to add those downloads steps into the pipeline steps for once for it to download and than remove it. --- **I'm still working on getting everything done without *ANY* touch of manual commands.**


# TODO's

1. Getting over the manual steps that's need to be commited in the ec2-server.
2. Make this project dynamic as possible to decrease human intervention in the ec2-server or the jenkinsfile.
3. Migrate the CD to the cloud (present: minikube, future: EKS).


# Challenges

1. created a terraform file to deploy a jenkins server with all the downloads needed (git, docker, datree, trivy etc..) - difficulties - getting all the downloads and manage to start all the services even after system reboot or stop and than run, on top of understanding who perreated a terraform file to deploy a jenkins server orms those command - "docker does not have permission"(whoiam) AND jenkins .ssh folder. - why I done it via the git repo. - jenkins plugins. - snyk plugins meetup.

2. Adjusting my on-premise jenkinsfile into the cloud jenkinsfile - ?

3. jenkins .ssh folder. - why I done it via the git repo. - jenkins plugins. - snyk plugins meetup.

4. Overcome many challenges and interacting with many tools th


# Additional Comments

Interacting with many tools for the first time.
Analizying the errors - which operation broke the pipeline.























## editing section ##


in the first steps I knew how to create a CI pipeline on-premise so I created a jenkins docker container and minikube argocd cluster.

working to get the whole process running-

ToDo:
1. Deploy Ci in the cloud - jenkins server.
2. adjusting the on-prem jenkinsfile to match the jenkins server in the cloud.
3. create ssh-keygen with auto generate so no need to enter location or press "enter".
down - stuck on one feature in order to make in perfect insted of moving forward.


benefits-  creative and take action

down- help to others - affects on my progress phase - together we are stronger, motivated and successful.