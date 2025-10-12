pipeline {
  agent any

  environment {
    IMAGE = "todo-app:latest"
    CONTAINER = "todo-app"
    HOST_DATA_DIR = "/home/ubuntu/todos_data"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh 'docker build -t ${IMAGE} .'
        }
      }
    }

    stage('Stop Previous Container') {
      steps {
        script {
          sh 'docker stop ${CONTAINER} || true'
          sh 'docker rm ${CONTAINER} || true'
        }
      }
    }

    stage('Run Container') {
      steps {
        script {
          sh "mkdir -p ${HOST_DATA_DIR} && sudo chown -R $(whoami):$(whoami) ${HOST_DATA_DIR} || true"
          sh "docker run -d --name ${CONTAINER} --restart unless-stopped -p 80:3000 -v ${HOST_DATA_DIR}:/data ${IMAGE}"
        }
      }
    }
  }

  post {
    success {
       echo "Deployed ${IMAGE} -> container ${CONTAINER}"
    }
    failure {
       echo "Pipeline failed"
    }
  }
}
