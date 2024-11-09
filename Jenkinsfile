def COLOR_MAP = [
    'SUCCESS': 'good',
    'FAILURE': 'danger',
    ]
    

pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
		IS_APPLIED = 0
    }
    
    
    tools {
        terraform 'Terraform' 
    } 

    stages {
        
        // Welcome Stage
        stage('Stage 1: Greeting') {
            steps {
                echo '################################################'
                echo 'WELCOME TO THE INFRASTRUCTURE BUILDING TOOL'
                echo '################################################'
            }
        }
        
        // Git Checkout to clone the repository
        stage('Stage 2: Git checkout') {
            steps {
                echo '1. Check out from git'
                git branch: 'main', credentialsId: 'github_login', url: 'https://github.com/jddbetambo/airbnb.git'
            }
        }
        
        
        // Start building the insfrastructure
        // Terraform init
        stage('Stage 4: Terraform Initialization') {
            steps {
                echo 'Terraform init code ....'
                sh 'terraform init'
            }
        }
        
        // Terraform validate
        stage('Stage 5: Terraform Code Validation') {
            steps {
                echo 'Terraform validate code ....'
                sh 'terraform validate'
            }
        }
        
        // Terraform plan
        stage('Stage 6: Terraform Code to plan the infrastructure') {
            steps {
                echo 'Terraform planning the insfrastructure ....'
                sh 'terraform plan'
            }
        }

        // Use Checkov to scan the terraform code
        stage('Checkov scan') {
            steps {
               
                sh 'sudo yum install python3-pip'           // Install the package python3-pip 
                sh 'sudo yum remove python3-requests'      // Remove the package python3-requests already with the AMI
                sh 'sudo pip3 install requests'            // Use pip3 to install the package called requests  
                sh 'sudo pip3 install checkov'             // Use pip3 to install the package called checkov   
                sh 'checkov -d . --skip-check CKV_AWS_79,CKV2_AWS_41'   // use checkov to scan the terraform code
            }
        }
        
        // Terraform apply
        stage('Stage 7: Terraform Code to appply/destroy the plan') {
            steps {
                echo 'Terraform apply the plan ....'
                sh 'terraform ${Apply_OR_Destroy} --auto-approve'
            }
        }
        
        // Farewell Stage
        // After cloning, list the content of the repository
        stage('Stage 3: Shell script to list the directory') {
            steps {
                echo '2. Content list of the Repersitory'
                sh 'ls -lR'
            }
        }
        
        // Closing
        stage('Stage 8: Closing') {
            steps {
                echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
                echo "This is my jenkins file to use"
                echo 'Goodbye !'
            }
        }
    }
    
     post { 
        always { 
            slackSend channel: '#jjtech-champions-devops-team', color: COLOR_MAP[currentBuild.currentResult], message: "Done by JDD. *${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }
}