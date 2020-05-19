pipeline {
    agent any
    stages {
        stage('Restore Packages') {
                steps {
                    bat "dotnet restore"
                }
        }
        stage('Build') {
                steps {
                    bat 'dotnet build'
                }
        }
        stage('Pack') {
           steps {
            	    bat 'dotnet pack --no-build --output nupkgs'
           	 }
        }
        stage('Run') {
                steps {
                    bat 'START /B dotnet C:/Program Files (x86)/Jenkins/workspace/Web7AgileProjectDhanya/ProjectAgileWeb7/bin/Debug/netcoreapp3.1/ProjectAgileWeb7.dll'
                }
        }

        stage('WEB7-153-ExternalAccount') {
            steps {
                sleep 10
		bat 'robot  ProjectAgileWeb7/Tests/WEB7-153-ExternalAccount.robot'
               
            }
           
        }
       stage('WEB7-176-BookingHistory') {
            steps {
                sleep 10
		bat 'robot  ProjectAgileWeb7/Tests/WEB7-176-BookingHistory.robot'
               
            }
           
        }
	stage('WEB7-34-Currency.robot') {
            steps {
                sleep 10
		bat 'robot  ProjectAgileWeb7/Tests/WEB7-34-Currency.robot'
               
            }
           
        }
	

    }
	
}