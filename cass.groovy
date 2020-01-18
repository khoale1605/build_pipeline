pipeline {
    agent any
    stages {
        stage ('Build Stage') {

            steps {
                withMaven(maven : 'mvn') {
                    bat 'mvn clean install'
                }
            }
        }
        stage ('Test Stage') {

            steps {
                withMaven(maven : 'mvn') {
                    bat 'mvn test'
                }
            }
        }
        stage ('Deployment Stage') {
            steps {
                withMaven(maven : 'mvn') {
                    bat 'mvn deploy'
                }
            }
        }
    }
}