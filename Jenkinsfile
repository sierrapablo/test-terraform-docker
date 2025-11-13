pipeline {
  agent any

  environment {
    TF_IN_AUTOMATION = 'true'
    PLAN_FILE = 'plan.tfplan'
    OUTPUT_FILE = 'hello_output.txt'
  }

  parameters {
    booleanParam(
      name: 'APPLY',
      defaultValue: false,
      description: 'Apply the Terraform plan after review'
    )
  }

  stages {
    stage('Checkout Repository') {
      steps {
        echo '📦 Clonando el repositorio...'
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        echo '🚀 Inicializando Terraform...'
        sh 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        echo '🧩 Generando plan de ejecución...'
        sh 'terraform plan -out=${PLAN_FILE}'
        archiveArtifacts artifacts: "${PLAN_FILE}", fingerprint: true
      }
    }

    stage('Terraform Apply') {
      when {
        expression { return params.APPLY == true }
      }
      steps {
        echo '⚙️ Aplicando plan...'
        sh "terraform apply ${PLAN_FILE}"
      }
    }

    stage('Capturar Output del Contenedor') {
      when {
        expression { return params.APPLY == true }
      }
      steps {
        echo '📜 Capturando logs del contenedor hello-world...'
        sh """
          docker logs hello-world-container > ${OUTPUT_FILE} 2>&1 || true
          echo '--- OUTPUT CAPTURADO ---'
          cat ${OUTPUT_FILE}
        """
      }
    }

    stage('Publicar Output en Jenkins') {
      steps {
        echo '📤 Guardando archivo de salida en Jenkins...'
        archiveArtifacts artifacts: "${OUTPUT_FILE}", fingerprint: true
      }
    }
  }

  post {
    always {
      script {
        if (params.APPLY) {
          echo '🧹 Limpiando recursos Terraform...'
          sh 'terraform destroy -auto-approve || true'
      } else {
          echo 'ℹ️ No se ejecutó apply, no hay recursos que limpiar.'
        }
      }
    }
    success {
      echo '✅ Pipeline ejecutado correctamente.'
    }
    failure {
      echo '❌ Hubo un fallo durante la ejecución.'
    }
  }
}
