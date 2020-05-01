pipeline {
    agent any
    stages {
    
        stage('Build') {
            steps{
                bat 'dotnet build'
            }
        }
        stage('Run Website'){
            steps{
                    bat 'START /B dotnet run'
            }
        }
        stage('Robot') {
            steps {
                    sleep 10
                    bat 'robot -d results/chrome --variable BROWSER:headlesschrome "ProjectAgileWeb7/Tests/web7.robot"'
                    
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
                               passThreshold       : 100,
                               unstableThreshold   : 95.0,
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