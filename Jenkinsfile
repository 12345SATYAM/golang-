pipeline {
    agent any
    parameters {
        choice(name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'], description: '')
        booleanParam(name: 'executeTests', defaultValue: true, description: '')
    }
    stages {
        stage("go mod download") {
            steps {
                
                }
            }
        }
        stage("go build -o <appname>") {
            steps {
                
            }
        }
        stage("golangci-lint run -c .golangci.yml") {
            when {
                expression {
                    params.executeTests
                }
            }
            steps {
                
                }
            }
        }
        stage("go test ./test/  -v") {
            steps {
                
            }
        }
        
      stage("go test -cover ./test/") {
            steps {
               
            }
        }  
    }  
}
