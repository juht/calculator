pipeline {
    agent any
    environment {
	registry = "juht/calculator"
        registryCredential = 'dockerhub'
 	dockerImage = ''
    }
    stages {
        stage ('Check out'){
            steps {
               git url: 'https://github.com/juht/calculator.git'
            }
        }
        stage ('Compile') {
            steps {
                sh './gradlew compileJava'
            }
        }
        stage ('Unit Test') {
           steps {
                sh "./gradlew test"
            }
        }
        stage ('Code Coverage'){
            steps {
                sh "./gradlew jacocoTestReport"
                publishHTML ( target: [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: "JaCoCo Report"
                ])
                sh "./gradlew jacocoTestCoverageVerification"
            }
        }
        stage ('Static Code Analysis'){
            steps {
                sh "./gradlew checkstyleMain"
                publishHTML (target: [
                    reportDir: 'build/reports/checkstyle/',
                    reportFiles: 'main.html',
                    reportName: "Checkstyle Report"
                ])
            }
        }
        stage ('Package'){
            steps {
                sh "./gradlew build"
            }
        }
        stage ('Docker Build') {
            steps {
		script {
		    dockerImage = docker.build registry + ":$BUILD_NUMBER"
		}
            }
        }
	stage('Deploy Image') {
	    steps {
		script {
		    docker.withRegistry('',registryCredential ) {
		        dockerImage.push()
		    }
		}
	    }
    	}
	stage('Acceptance Testing'){
	    steps {
		script {
		    docker.withServer('tcp://docker:2376',''){
			dockerImage.withRun('-p 8090:8090') {
			     sleep 10
			     sh './acceptance_test.bash'
			}
		    }
		}
	    }
        }
    }
}
