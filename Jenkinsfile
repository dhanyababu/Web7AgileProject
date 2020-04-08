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
    		    sh 'dotnet restore ProjectAgileWeb7.sln'
		    sh('\"%MSBUILD_HOME%/msbuild.exe\" ProjectAgileWeb7.sln')
    		}
	    }

        stage('robot') {
                    steps {
			    sh 'robot -d results --variable BROWSER:headlesschrome ProjectAgileWeb7/Web7.robot'
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



