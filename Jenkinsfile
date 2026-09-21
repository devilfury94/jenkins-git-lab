pipeline {
    agent any

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

    }
}
