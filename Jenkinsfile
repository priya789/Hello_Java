pipeline{
  agent any 
    stages {
      stage('checkout'){
      steps {
                git branch: 'master', url: "https://github.com/priya789/Hello_Java.git"
            }
      }
      
      stage('build'){
      steps{
           sh 'mvn "flyway:repair" "flyway:migrate" "flyway:validate" "flyway:info"'  
        }
      }
      }
}
