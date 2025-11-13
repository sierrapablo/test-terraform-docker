pipeline {
  agent any

  environment {
    TF_IN_AUTOMATION = 'true'
    PLAN_FILE = 'plan.tfplan'
  }

  stages {
    stage('Checkout') {
      steps {
        echo 'Clonando repositorio...'
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        echo 'Inicializando Terraform...'
        sh 'terraform init -input=false'
      }
    }

    stage('Terraform Plan') {
      steps {
        echo 'Generando plan de ejecución...'
        sh "terraform plan -out=${PLAN_FILE}"
        archiveArtifacts artifacts: "${PLAN_FILE}", fingerprint: true
      }
    }

    stage('Approval') {
      steps {
        script {
          input message: '¿Aplicar cambios de Terraform?', ok: 'Sí'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        echo 'Aplicando plan...'
        sh "terraform apply ${PLAN_FILE}"
      }
    }
  }

  post {
    success {
      echo 'Pipeline ejecutado correctamente.'
    }
    failure {
      echo 'Hubo un fallo durante la ejecución.'
    }
  }
}
