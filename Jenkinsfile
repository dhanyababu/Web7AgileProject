pipeline {

    agent any

    stages {
        stage('Checkout') {
                steps {
                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/dhanyababu/Web7AgileProject.git']]])
                }
        }
        stage('Restore') {
            steps {
                bat 'dotnet restore'
            }
        }
        stage('Build') {
            steps {
                bat '"C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/MSBuild/Current/Bin/MSBuild.exe" ProjectAgileWeb7.sln'
            }
        }
        stage('Run') {
            steps {
               bat 'START /B dotnet "C:/Users/dhany/IdeaProjects/dhanyaBranch/ProjectAgileWeb7/bin/Debug/netcoreapp3.1/ProjectAgileWeb7.dll"'
            }
        }
        stage('UI tests') {
            steps {
                    bat 'sleep 10s'
                    bat 'robot Tests'
            }
        }
    }
}
