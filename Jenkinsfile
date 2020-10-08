pipeline {
  parameters {
    password (name: 'AWS_ACCESS_KEY_ID')
    password (name: 'AWS_SECRET_ACCESS_KEY')
  }
  environment {
    TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
    TF_HOME = "/usr/local/bin/"
    AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
  }
  agent { label 'master' }
  stages {
    stage('Terraform Init') {
      steps {
        sh "pwd"
        sh "${env.TF_HOME}/terraform init -input=false"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=tfplan -input=false -var-file='dev.tfvars'"
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "terraform apply -input=false tfplan"
      }
    }
    stage('AWSpec Tests') {
      steps {
          sh '''#!/bin/bash -l
bundle install --path ~/.gem
bundle exec rake spec || true
'''

        junit(allowEmptyResults: true, testResults: '**/testResults/*.xml')
      }
    }
  }
}
