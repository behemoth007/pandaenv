pipeline {
    agent {
        label 'Slave'
    }

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "auto_maven"
    }

    enviroment {
        // Import environment from maven to jenkins
        IMAGE = readMavenPom().getArtifactId()
        VERSION = readMavenPom().getVersion()
    }

    stages {
        stage('Clear running apps') {
            steps {
                //clear previous instances of app biult
               sh 'docker rm -f pandaapp || true'
            }
        }
        stage('Get Code') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'feature/seleniumgrid', credentialsId: 'github', url: 'https://github.com/behemoth007/pandaenv.git'
            }
        }
        stage('Build and Junit') {
            steps {
                // run Maven on a Unix agent.
                sh 'mvn clean install'
            }
        }
        stage('Build Docker image') {
            steps {
                sh 'mvn package -Pdocker'
            }
        }
        stage('Test Selenium') {
            steps {
                sh 'mvn test -Pselenium'
            }
        }
        stage('Run Docker app') {
            steps {
                sh 'docker run -d -p 0.0.0.0:8090:8080 --name pandaapp -t ${IMAGE}:${VERSION}'
                //sh 'mvn clean install'
            }        
        }        
        stage('Deploy to artifactory') 
        {
            steps {
                configFileProvider([configFile(fileId: '53611461-edc2-493b-b3d6-02db5a773d03', variable: 'MAVEN_SETTINGS')]) {
                    sh  'mvn -gs $MAVEN_SETTINGS deploy'
                }
            }
            post {
                always {
                    sh 'docker stop pandaapp'
                    deleteDir()
                }           
            }
        }
    }    
}