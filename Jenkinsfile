//def ReleaseDir = "c:\inetpub\wwwroot"
 pipeline {
    agent any
     stages {
         stage('Checkout') {
            steps {
                git 'https://github.com/dhanyababu/Web7AgileProject'
             }
        }
        stage('Source'){
		    steps{
			    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '825fc4d4-4161-4170-9587-28a936f82af6', url: 'https://github.com/dhanyababu/Web7AgileProject']]])
		    }
	    }
	    stage('Build') {
    		steps {
    		    sh 'nuget restore ProjectAgileWeb7.sln'
    			sh '\'${tool "MSBuild"}\' ProjectAgileWeb7.sln /p:DeployOnBuild=true /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:SkipInvalidConfigurations=true /t:build /p:Configuration=Release /p:Platform=\"Any CPU\" /p:DeleteExistingFiles=True /p:publishUrl=c:\\inetpub\\wwwroot'
    		}
	    }

        stage('robot') {
                    steps {
                        sh 'robot -d results --variable BROWSER:headlesschrome Web7.robot'
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



