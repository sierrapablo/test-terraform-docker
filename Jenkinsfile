pipeline {
  agent any

  parameters {
    choice(
      name: 'MACHINE_SIZE',
      choices: ['s','m','l','xl'],
      description: 'Tamaño de la máquina',
      default: 's'
    )
  }

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
        script {
          def cpu, memory
          switch(params.MACHINE_SIZE) {
            case 's':
              cpu = 1
              memory = 500000000
              break
            case 'm':
              cpu = 2
              memory = 1000000000
              break
            case 'l':
              cpu = 4
              memory = 4000000000
              break
            case 'xl':
              cpu = 0   // sin límite
              memory = 0
              break
          }
          sh "terraform plan -var='cpu=${cpu}' -var='memory=${memory}' -out=plan.tfplan"
        }
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
