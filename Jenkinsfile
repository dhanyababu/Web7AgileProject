pipeline {
    agent any

    stages {
        stage('Checkout') {
                steps {
                    checkout([$class: 'GitSCM', branches: [[name: '*/DhanyaTest']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/dhanyababu/Web7AgileProject.git']]])
                }
        }
        stage('Restore Packages') {
                steps {
                    bat "dotnet restore"
                }
        }
        stage('Build') {
                steps {
                    bat 'dotnet build ProjectAgileWeb7.sln'
                }
        }
        stage('Pack') {
           	    steps {
            	    bat 'dotnet pack --no-build --output nupkgs'
           	    }
        }
        stage('Run') {
                steps {
                    bat 'START /B dotnet run'
                }
        }

        stage('Robot') {
            steps {
                sleep 10
                bat 'robot  ProjectAgileWeb7/Tests/web7.robot'
            }
           
        }
    }
	
}
