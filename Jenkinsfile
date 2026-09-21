pipeline {
    agent any

    stages {
        stage('Workspace') {
            steps {
                sh 'pwd'
            }
        }

         stage('Files') {
            steps {
                sh 'ls'
            }
        }

        stage('Test') {
            steps {
                sh 'python3 hello.py | grep -q "Hello from GitHub - version 2"'
            }
        }
        
        stage('Run Build Info') {
            steps {
                sh 'python3 build-info.py'
            }
        }

    }
}
