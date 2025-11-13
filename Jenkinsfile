pipeline {
  agent any

  parameters {
    choice(
      name: 'MACHINE_SIZE',
      choices: ['s', 'm', 'l', 'xl'],
      description: 'Tamaño de la máquina'
    )
  }

  environment {
    TF_IN_AUTOMATION = 'true'
    PLAN_FILE        = 'plan.tfplan'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init -input=false'
      }
    }

    stage('Terraform Plan') {
      steps {
        script {
          def cpu, memory
          switch (params.MACHINE_SIZE) {
            case 's':
              cpu = 1024
              memory = 500000000
              break
            case 'm':
              cpu = 2048
              memory = 1000000000
              break
            case 'l':
              cpu = 4096
              memory = 4000000000
              break
            case 'xl':
              cpu = 0
              memory = 0
              break
          }

          // Generar hash corto basado en BUILD_NUMBER para que sea único
          def suffix = sh(script: "echo ${env.BUILD_NUMBER} | md5sum | cut -c1-6", returnStdout: true).trim()

          sh "terraform plan -var='machine_size=${params.MACHINE_SIZE}' -var='cpu=${cpu}' -var='memory=${memory}' -var='container_suffix=${suffix}' -out=${PLAN_FILE}"
          archiveArtifacts artifacts: "${PLAN_FILE}", fingerprint: true
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
