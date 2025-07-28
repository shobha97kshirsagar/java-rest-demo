pipeline {
    agent any

  
    environment {
        IMAGE_NAME = 'priya123456/restapi'
        CONTAINER_NAME = 'restapi-container'
        PORT_MAPPING = '8081:7000'  // hostPort:containerPort
    }

    stages {
        stage('Checkout') {
            steps {
              echo "git checkout completed"
              // git branch: 'main', url: 'https://github.com/priyabuss2004/java-rest-demo.git'
              
            }
        }
        
         stage('Build') {
            steps {
               sh 'mvn clean compile'
            }
        }
  
  
      stage('Test') {
            steps {
               sh 'mvn test'
            }
        }
    
    stage('Package') {
            steps {
            // create pakage for appplication without running test cases    
               sh 'mvn package -DskipTests'
            }
        }
    
    
    stage('Build Image') {
            steps {
             sh '''
             getent group docker
             docker build -t $IMAGE_NAME .
            '''
          }
        }
        
           stage(' Push Image') {
            steps {
                 withCredentials([usernamePassword(credentialsId: 'dockerhub-token', usernameVariable: 'MY_DOCKER_USER',
    passwordVariable: 'MY_DOCKER_PASS')]) {
                    sh '''
                        echo "$MY_DOCKER_PASS" | docker login -u "$MY_DOCKER_USER" --password-stdin
                        docker push $IMAGE_NAME
                       
                   '''
              }
        }
     }
     
      stage('Run Container') {
            steps {
                sh '''
                    # Stop and remove existing container if it exists
                    docker rm -f $CONTAINER_NAME || true
                    
                    # Run new container in detached mode
                    docker run -d --name $CONTAINER_NAME -p $PORT_MAPPING $IMAGE_NAME
                    
                    # Optional: wait for container to be healthy/ready
                    sleep 5
                    docker ps | grep $CONTAINER_NAME
                '''
            }
        }
     
  
    } // End of stages
    
    
    post{
        success {
            echo "Pipeline completed successfully"
        }
        
        failure{
            echo "pipeline failed"
        }
    }
    
    
} // End of pipeline
