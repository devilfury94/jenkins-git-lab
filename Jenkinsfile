pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                sh 'echo "Hello Pipeline"'
            }
        }

        stage('Run Python') {
            steps {
                sh 'python3 hello.py'
            }
        }

        stage('Inspect') {
            steps {
                sh 'pwd'
                sh 'ls'
            }
        }
    }
}
