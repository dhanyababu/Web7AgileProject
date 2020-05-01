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
                    bat 'START /B dotnet C:/Program Files (x86)/Jenkins/workspace/Web7AgileProjectDhanya/ProjectAgileWeb7/bin/Debug/netcoreapp3.1/ProjectAgileWeb7.dll'
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