pipeline {
  agent any

    stages {

        stage ('Stage 1 - Build the docker image') {
            steps {
                script {
                    sh "docker build -t levvv/java-maven-app:latest java-maven-app/"
                }
            }
        }
        stage ('Stage 2 - Run & test the image') {
            steps {

                sh "docker run -d -p 8085:8080 --name testingjava levvv/java-maven-app:latest"
                sh 'wget --tries=10 --waitretry=5 --retry-connrefused -O- localhost:8085'

            }
        }
      
        stage('STAGE 1 check if branch exists') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        echo '---------Hello from main branch--------------'  
                        script {
                            sh "git config --global user.email 'levmeshorer16@gmail.com'"
                            sh "git config --global user.name 'Lev Meshorer (EC2 JENKINS)'"
                            sh "git fetch --tags"
                            majorMinor = sh(script: "git tag -l --sort=v:refname | tail -1 | cut -c 1-3", returnStdout: true).trim()
                            echo "$majorMinor"
                            previousTag = sh(script: "git describe --tags --abbrev=0 | grep -E '^$majorMinor' || true", returnStdout: true).trim()  // x.y.z or empty string. grep is used to prevent returning a tag from another release branch; true is used to not fail the pipeline if grep returns nothing.
                            echo "$previousTag"
                            if (!previousTag) {
                            patch = "0"
                            } else {
                            patch = (previousTag.tokenize(".")[2].toInteger() + 1).toString()
                            }
                            env.VERSION = majorMinor + "." + patch
                            echo env.version
                            echo env.BRANCH_NAME
                        }
                    }
                }
            }
        }

        stage ('Stage 3 - Publish to DockerHub') {
            steps {
                sh "docker tag levvv/java-maven-app:latest levvv/java-maven-app:$env.VERSION"

                withCredentials([usernamePassword(credentialsId: 'docker-hub-account', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "docker login --username=$USERNAME --password=$PASSWORD"
                    sh "docker push levvv/java-maven-app:$env.VERSION"
                    //sh "echo TAG=$env.VERSION > version.txt"
                    //sh "git tag $env.VERSION"
                    sh "git tag -a ${env.VERSION} -m 'version ${env.VERSION}'"
                    sh "git push --tag"
                }
            }
        }
      
        stage ('Stage 4 - Editing the helm chart') {
            steps {
                sh "git clone git@github.com:LevMesh/Source-code-Deployment.git"
                sh "sed -i 's/tag: .*/tag: ${env.VERSION}/g' Source-code-Deployment/k8s/my-app/values.yaml"
                dir('Source-code-Deployment') {
                    sh 'git add .'
                    sh "git commit -am 'Automated commit by Jenkins'"
                    sh 'git push'
                }
            }
        }


    // stage ('STAGE 5 Release (push to ECR)') {

    // }

    }

  
  
  post ('CleanWorkspace'){
    always {
      sh 'docker rm -f testingjava'
      cleanWs()
      
    }
  }
}
