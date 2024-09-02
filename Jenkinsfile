pipeline {
    agent any
    stages{
        stage('build project'){
            steps{
                git url:'https://github.com/PoojaPulivarthi/Project1/', branch: "master"
                sh 'mvn clean package'
              
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t staragileprojectfinance:v1 .'
                    sh 'docker images'
                }
            }
        }
        
     stage('Deploy') {
            steps {
                sh 'sudo docker run -itd --name My-container1 -p 8083:8081 staragileprojectfinance:v1'
                  
                }
            }
        
    }
}
