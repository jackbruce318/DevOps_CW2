//Jenkinsfile (Declarative Pipeline)
pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS = credentials('74bc5dfa-0f0b-456d-b5b7-d0aba00917f4')
	}
	stages {

		stage('Docker Image Build') {
			steps {
				echo 'Building Docker Image...'
				sh 'docker build --tag jackbruce318/cw2-server:1.0 .')
				echo 'Docker Image built successfully!'
			}
		}

		stage('Test Docker Image') {
			steps {
				echo 'Testing Docker Image...'
				sh '''
					docker image inspect jackbruce318/cw2-server:1.0
					docker run --name test-container -p 8081:8080 -d jackbruce318/cw2-server:1.0
					docker ps
					docker stop test-container
					docker rm test-container
				'''
			}
		}

		stage('DockerHub Login') {
			steps {
				sh 'echo $DOCKERHUB_CREDS_PSw | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
			}
		}

		stage('DockerHub Image Push') {
			steps {
				sh 'docker push jackbruce318/cw2-server:1.0'
			}
		}
	}
