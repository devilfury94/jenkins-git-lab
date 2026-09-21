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
        
        stage('Test Build Info') {
            steps {
                sh 'python3 build-info.py | grep -q "This is the file I made for my test"'
            }
        }

        stage('Run Build Info') {
            steps {
                sh 'python3 build-info.py'
            }
        }

    }
}
