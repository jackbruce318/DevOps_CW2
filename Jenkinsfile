//Jenkinsfile (Declarative Pipeline)
pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS = credentials('docker')
	}
	stages {

		stage('Docker Image Build') {
			steps {
				echo 'Building Docker Image...'
				sh 'docker build --tag jackbruce318/cw2-server:6.0 .'
				echo 'Docker Image built successfully!'
			}
		}

		stage('Test Docker Image') {
			steps {
				echo 'Testing Docker Image...'
				sh '''
					docker image inspect jackbruce318/cw2-server:6.0
					docker run --name test-container -p 8081:8080 -d jackbruce318/cw2-server:6.0
					docker ps
					docker stop test-container
					docker rm test-container
				'''
			}
		}

		stage('DockerHub Login') {
			steps {
				sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
			}
		}

		stage('DockerHub Image Push') {
			steps {
				sh 'docker push jackbruce318/cw2-server:6.0'
			}
		}

		stage('Deploy Image') {
			steps {
				sshagent(['my-k8s-key']) {
					sh ''' 
						ssh -tt ubuntu@3.91.241.177 "pwd && kubectl set image deployment/cw2-test cw2-server=jackbruce318/cw2-server:6.0"
					'''
				}
			}			
		}
	}
}
