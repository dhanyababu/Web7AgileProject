pipeline {

    agent any

    stages {
        stage('Checkout') {
                steps {
                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/dhanyababu/Web7AgileProject.git']]])
                }
        }
        stage('Build') {
            steps {
                bat 'dotnet build'
            }
        }
        stage('Run') {
            steps {
                bat 'START /B dotnet run'
            }
        }
        stage('UI tests') {
            steps {
                    sleep 10s
                    bat 'robot Tests'
            }
        }
    }
	post{
	    always{
            bat 'TASKKILL /F /IM dotnet.exe'
	    }
       }
}
