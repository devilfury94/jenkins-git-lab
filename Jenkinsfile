pipeline {
    agent any

   environment {
        IMAGE_NAME = 'jenkins-docker-app'
        }

    parameters {
        string(
            name: 'IMAGE_TAG',
            defaultValue: 'j30-final-v1',
            description: 'docker image version'
            )
         string(
            name: 'APP_VERSION',
            defaultValue: 'j30-final-v1',
            description: 'version printed by app.py'
            )
         choice(
            name: 'APP_ENV',
            choices: ['staging', 'production'],
            description: 'Application environment'
            )
        }
    
    stages {
        stage('Workspace') {
            steps {
                sh 'pwd'
            }
        }

         stage('Test App') {
            steps {
                sh 'python3 app.py | grep -Fxq "DEVOPS FINAL | VERSION=$APP_VERSION | ENV=$APP_ENV"'
            }
        }
        
        stage('Test Build Info') {
            steps {
                sh 'python3 build-info.py | grep -q "This is the file I made for my test"'
            }
        }

        stage('Build') {
            steps {
                sh 'python3 build-info.py'
            }
        }

       stage('Login Credential Check') {
    steps {
        withCredentials([
            usernamePassword(
                credentialsId: 'devops-login-demo',
                usernameVariable: 'DEMO_USER',
                passwordVariable: 'DEMO_PASS'
            )
        ]) {
            sh '''
                set +x
                test -n "$DEMO_USER" &&
                test -n "$DEMO_PASS" &&
                echo "Login credentials loaded"
            '''
        }
    }
}


stage('Credentials Audit') {
    steps {
        withCredentials([
            string(
                credentialsId: 'devops-token-demo',
                variable: 'DEMO_TOKEN'
            ),
            usernamePassword(
                credentialsId: 'devops-login-demo',
                usernameVariable: 'DEMO_USER',
                passwordVariable: 'DEMO_PASS'
            )
        ]) {
            sh '''
                set +x
                test -n "$DEMO_TOKEN" &&
                test -n "$DEMO_USER" &&
                test -n "$DEMO_PASS" &&
                echo "All credentials loaded"
            '''
        }
    }
}

        
        stage('Docker Build') {
            steps {
                sh 'docker build -t "$IMAGE_NAME:$IMAGE_TAG" .'
            }
        }
        
       stage('Docker Run Test') {
            steps {
                sh 'docker run "$IMAGE_NAME:$IMAGE_TAG"'
                sh 'docker run "$IMAGE_NAME:$IMAGE_TAG" | grep -q "Hello from GitHub - version 3"'
            }
       }
        
stage('Docker Hub Publish') {
    steps {
        withCredentials([
            usernamePassword(
                credentialsId: 'dockerhub-jenkins',
                usernameVariable: 'DOCKER_USER',
                passwordVariable: 'DOCKER_TOKEN'
            )
        ]) {
            sh '''
                set +x
                set -eu

                export DOCKER_CONFIG="$(mktemp -d)"
                trap 'rm -rf "$DOCKER_CONFIG"' EXIT

                printf '%s' "$DOCKER_TOKEN" |
                    docker login -u "$DOCKER_USER" --password-stdin

                docker tag "$IMAGE_NAME:$IMAGE_TAG" \
                    "$DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG"

                docker push "$DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG"
            '''
        }
    }
}

    }
}
    

