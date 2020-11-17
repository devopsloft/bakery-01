pipeline { 
    agent any
    stages {
        stage('Build') { 
            steps {
                echo $JOB_NAME
				echo "current build number: ${currentBuild.number}"
                }
            }
        }
        post {
            success {
                echo "Great success!!"
        }
			failure {
				echo "There is no spoon..."
                }

            }
}
