pipeline {
  environment {
    TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
    TF_HOME = "/usr/local/bin/"
  }
  agent { label 'master' }
  stages {
    stage('Environment Prep') {
      steps {
        sh "ls -la"
        sh "rm -rf DevSecOps-Labs"
        sh "cp /tmp/terraform.tfvars ./"
        sh "cat dev.tfvars >> terraform.tfvars && cat terraform.tfvars >> dev.tfvars"
      }
    }
    stage('Terraform Init') {
      steps {
        sh "ls -la"
        sh "${env.TF_HOME}terraform init -input=false -var-file='dev.tfvars'"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "${env.TF_HOME}terraform plan -out=tfplan -input=false -var-file='dev.tfvars'"
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "${env.TF_HOME}terraform apply -input=false tfplan"
      }
    }
    stage('Terraform Destroy') {
      steps {
        input 'Destroy Plan'
        sh "${env.TF_HOME}terraform destroy -input=false -auto-approve=true"
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
    stage('Cleanup') {
      steps {
        sh "rm -rf ./*"
      }
  }
  }
}
