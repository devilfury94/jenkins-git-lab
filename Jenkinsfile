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

        stage('Run Build Info') {
            steps {
                sh 'python3 build-info.py'
            }
        }
    }
}
