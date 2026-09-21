pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                sh 'echo "Hello Pipeline"'
            }
        }

         stage('Inspect') {
            steps {
                sh 'pwd'
                sh 'ls'
            }
        }

        stage('Run Python') {
            steps {
                sh 'python3 hello.py'
            }
        }
    }
}
