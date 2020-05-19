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
                    bat 'START /B dotnet C:/Users/abram/.jenkins/workspace/WebAgile7/ProjectAgileWeb7/bin/Debug/netcoreapp3.1/ProjectAgileWeb7.dll'
                }
        }

        stage('login') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB718-loginTest.robot'

            }

        }

	stage('expdate') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB7198-expDate.robot'

            }
	}
        stage('remember') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB718-remember.robot'

            }

        }
        stage('Search') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB723-search.robot'

            }

        }
    }

}