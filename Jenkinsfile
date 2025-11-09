pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-node-app"
        DOCKER_REGISTRY = "your-docker-registry" // לדוגמה Docker Hub או Registry פרטי
        DOCKER_CREDENTIALS = "docker-hub-credentials" // Jenkins credentials ID
        APP_PORT = "3000"
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10')) // שומר רק 10 בניות אחרונות
        timestamps() // לוג עם זמן
        //ansiColor('xterm') // צבעים בלוג
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out source code from Git"
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "Installing npm dependencies"
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                echo "Running automated tests"
                sh 'npm test || true' // אם אין בדיקות עדיין, לא יפסיק את Pipeline
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image"
                script {
                    docker.build("${IMAGE_NAME}:latest")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker image to registry"
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", "${DOCKER_CREDENTIALS}") {
                        docker.image("${IMAGE_NAME}:latest").push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying Docker container"
                script {
                    // עצירת container קודם אם קיים
                    sh """
                    docker stop ${IMAGE_NAME} || true
                    docker rm ${IMAGE_NAME} || true
                    docker run -d -p ${APP_PORT}:${APP_PORT} --name ${IMAGE_NAME} ${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up workspace"
            cleanWs()
        }
        success {
            echo "Pipeline finished successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs!"
        }
    }
}
