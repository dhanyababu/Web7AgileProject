//def ReleaseDir = "c:\inetpub\wwwroot"
 pipeline {
    agent any
     stages {
         stage('Checkout') {
            steps {
                git 'https://github.com/dhanyababu/Web7AgileProject'
             }
        }
        
	    stage('Build') {
    		steps {
    		    bat 'dotnet restore ProjectAgileWeb7.sln'
		    bat "\"${tool 'MSBuild'}\"  ProjectAgileWeb7.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
    		}
	    }

        stage('robot') {
                    steps {
			    bat 'robot -d results --variable BROWSER:headlesschrome ProjectAgileWeb7/Web7.robot'
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
 }



