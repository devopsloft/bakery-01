pipeline { 
    agent any
    stages {

        stage('Build') { 
            steps {
			echo 'Start build'
                	sh 'docker build -t microblog:latest .'
			sh 'docker run --name microblogFromJenkins -d -p 8001:5000 --rm microblog:latest'
			  
            }
	}
                        }
        post {
            success {
                echo "Pipeline successful"
        }
	    failure {
		 echo "The Pipeline failed :("
		    }
	}
	 }
