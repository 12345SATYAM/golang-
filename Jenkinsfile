pipeline {
    agent any
    tools {
        go 'go'
    }
    environment {
        GO117MODULE = 'on'
        CGO_ENABLED = 0 
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
    }
    stages { 
        stage('Pre Test'){
            steps{
                echo 'downloading all the dependencies'
            
                sh 'go version'
                sh 'go mod download'
                //or -update
                //sh 'cd ${GOPATH}/src/cmd/project/ && dep ensure' 
                }
            }
                stage('Build'){
                    steps{
                        echo 'build the go app'
                        //sh 'go build -o <appname>'
                         }
                     }
                stage('Checking'){
                    steps{
                        echo 'checking lint issues'
                        //sh 'golangci-lint run -c .golangci.yml'
                         }
                }
                stage('Testing'){
                    steps{
                        echo 'running test cases'
                        //sh 'go test ./test/  -v'
                        echo 'test cases coverage'
                        //sh 'go test -cover ./test/'
                         }   
                     }  
            }
        }
