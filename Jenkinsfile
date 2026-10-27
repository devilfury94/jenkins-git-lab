pipeline {
    agent any

   environment {
        IMAGE_NAME = 'jenkins-docker-app'
        }

    parameters {
        string(
            name: 'IMAGE_TAG',
            defaultValue: 'day27',
            description: 'Docker image tag'
            )
        }
    
    stages {
        stage('Workspace') {
            steps {
                sh 'pwd'
            }
        }

         stage('Test Hello') {
            steps {
                sh 'python3 hello.py | grep -q "Hello from GitHub - version 3"'
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

        stage('Release Summary') {
            steps {
                sh 'echo "$IMAGE_NAME" | grep -q "devilfury/jenkins-docker-app:j29-final-v1"'
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
    

