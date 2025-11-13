pipeline {
  agent any

  parameters {
      choice(
        name: 'MACHINE_SIZE',
        choices: ['s', 'm', 'l'],
        description: 'Container size'
      )
  }

  environment {
      TF_VAR_machine_size = "${params.MACHINE_SIZE}"
  }

  stages {
    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh 'terraform init -input=false'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          sh '''
            terraform plan -out=plan.tfplan
          '''
        }
      }
    }

    stage('Approve Plan') {
      steps {
        script {
          input message: "¿Aplicar este plan de Terraform para MACHINE_SIZE=${params.MACHINE_SIZE}?", ok: 'Aplicar'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          sh '''
            terraform apply -input=false plan.tfplan
          '''
        }
      }
    }

    stage('Container Info') {
      steps {
        dir('terraform') {
          sh """
            echo "Container created:"
            terraform output container_name
            echo ""
            echo "To access:"
            echo "docker exec -it \$(terraform output -raw container_name) bash"
          """
        }
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
