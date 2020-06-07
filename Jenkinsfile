pipeline {
    agent any
    environment {
	registry = "juht/calculator"
	registryCredential="dockerhub"
	dockerImage=''
    }
    stages {
        stage ('Check out'){
            steps {
		git branch: 'uat', url: 'https://github.com/juht/calculator.git'
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
	stage('Packaging') {
	    steps {
		sh "./gradlew build"
	    }
        }
	stage('Deploy Image'){
	    steps {
		script {
		   dockerImage = docker.build registry + ":$BUILD_NUMBER"
		}
	    }
        }
	stage('Push Image') {
	   steps {
		script {
		     docker.withRegistry('',registryCredential ) {
			dockerImage.push()
			dockerImage.push("latest")
		     }
                }
           }
       }
       stage('Deploy to staging'){
	   steps {
		script {
		    docker.withServer('tpc://docker:2376','') {
			dockerImage.run("-p 8090:8090") {
			    sleep 10
			    sh 'curl -X GET http://docker:8090/sum?a=2\\&b=3'
			}
		    }
                }
           }
       }
    }
}
