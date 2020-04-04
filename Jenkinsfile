//def ReleaseDir = "c:\inetpub\wwwroot"
pipeline {
    agent any
     stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/dhanyababu/Web7AgileProject'
             }
        }
        stage('Build1') {
            steps {
                sh "mvn compile"
            }
        }
       stage('Test') {
            steps {
                sh "mvn test"
            }
       }
       stage('newman') {
            steps {
                sh 'newman run Restful_Booker.postman_collection.json --environment Restful_Booker.postman_environment.json --reporters junit'
            }
            post {
                always {
                     junit '**/*xml'
                }
            }

       }
	stage('Source'){
		steps{
			checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '825fc4d4-4161-4170-9587-28a936f82af6', url: 'http://172.30.11.178/abhishek1/aspdotnetjenkins']]])
		}
	}
	stage('Build2') {
    		steps {
    			sh "\"${tool 'MSBuild'}\" AspDotNetJenkins.sln /p:DeployOnBuild=true /p:DeployDefaultTarget=WebPublish /p:WebPublishMethod=FileSystem /p:SkipInvalidConfigurations=true /t:build /p:Configuration=Release /p:Platform=\"Any CPU\" /p:DeleteExistingFiles=True /p:publishUrl=c:\\inetpub\\wwwroot"
    		}
	}

       

        stage('robot') {
                    steps {
                        sh 'robot -d results --variable BROWSER:headlesschrome infotivHome.robot'
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

    post {
        always {
            junit '**/TEST*.xml'           
            emailext attachLog: true, attachmentsPattern: '**/TEST*xml',
            body: '', recipientProviders: [culprits()], subject:
            '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!'

        }
    }
 }

