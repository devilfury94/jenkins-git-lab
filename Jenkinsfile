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
                sh 'python3 hello.py | grep -q "Hello from GitHub - version 2"'
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

        stage('Credential Check') {
    steps {
        withCredentials([
            string(
                credentialsId: 'devops-token-demo',
                variable: 'DEMO_TOKEN'
            )
        ]) {
            sh '''
                set +x
                test -n "$DEMO_TOKEN" && echo "Credential loaded"
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
                sh 'docker run "$IMAGE_NAME:$IMAGE_TAG" | grep -q "Hello from GitHub - version 2"'
            }
       }
    }
}
    

