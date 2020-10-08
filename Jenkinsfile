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
        sh "rm -rf ./*"
        sh "git clone https://github.com/DolpheusLabs/DevSecOps-Labs"
        sh "cp -r ./DevSecOps-Labs/* ./"
        sh "cat /tmp/credentials.tfvars >> dev.tfvars"
      }
    }
    stage('Terraform Init') {
      steps {
        sh "ls -la"
        sh "echo $env.AWS_ACCESS_KEY_ID"
        sh "${env.TF_HOME}terraform init -input=false -var-file='dev.tfvars'"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "${env.TF_HOME}terraform plan -out=tfplan -input=false "
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "${env.TF_HOME}terraform apply -input=false tfplan"
        sh "sleep 5"
      }
    }
    stage('Terraform Destroy') {
      steps {
        input 'Destroy Plan'
        sh "${env.TF_HOME}terraform destroy -auto-approve"
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
