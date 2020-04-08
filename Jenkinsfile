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
    			sh '\'${tool "MSBuild"}\' ProjectAgileWeb7.sln /p:DeployOnBuild=true /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:SkipInvalidConfigurations=true /t:build /p:Configuration=Release /p:Platform=\"Any CPU\" /p:DeleteExistingFiles=True /p:publishUrl=c:\\inetpub\\wwwroot'
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



