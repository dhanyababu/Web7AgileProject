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
        stage('Robot') {
            steps {
                    sleep 10
                    bat 'robot -d results --variable BROWSER:headlesschrome "ProjectAgileWeb7/Tests/web7.robot"'
            }
            post {
                always {
                    script {
                        step(
                             [
                               $class              : 'RobotPublisher',
                               outputPath          : 'results',
                               outputFileName      : '**/output.xml',
                               reportFileName      : '**/report.html',
                               logFileName         : '**/log.html',
                               disableArchiveOutput: false,
                               passThreshold       : 50,
                               unstableThreshold   : 40,
                               otherFiles          : "**/*.png,**/*.jpg",
                            ]
                        )
                    }
                }
            }

        }
	    
    }
	post{
	    always{
            bat 'TASKKILL /F /IM dotnet.exe'
	    }
       }
}
