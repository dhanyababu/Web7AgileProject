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
	stage('filters') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB726-filters.robot'

            }

        }
	stage('respfilters') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB726-respFilters.robot'

            }

        }
	stage('book') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB727and28-book.robot'

            }

        }
	stage('favourites') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB730-myFavourites.robot'

            }

        }
	stage('weather') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB733-weather.robot'

            }

        }
	stage('nearbyplaces') {
            steps {
                sleep 10
        bat 'robot  ProjectAgileWeb7/Tester/WEB7204-nearbyplaces.robot'

            }

        }

    }

}