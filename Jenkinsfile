// Declarative style
// pipeline {
//     agent {
//         docker {
//             image 'maven:3.9.0'
//             args '-v /root/.m2:/root/.m2'
//         }
//     }
//     stages {
//         stage('Build') {
//             steps {
//                 sh 'mvn -B -DskipTests clean package'
//             }
//         }
//         stage('Test') {
//             steps {
//                 sh 'mvn test'
//             }
//             post {
//                 always {
//                     junit 'target/surefire-reports/*.xml'
//                 }
//             }
//         }
//         stage('Deliver') {
//             steps {
//                 sh './jenkins/scripts/deliver.sh'
//             }
//         }
//     }
// }

// Scripted Style
node {
    docker.image('maven:3.9.0').inside('-v /root/.m2:/root/.m2') {
        stage('Build') {
            sh 'mvn -B -DskipTests clean package'
            }
        stage('Test') {
            try {
                sh 'mvn test'
            } finally {
                junit 'target/surefire-reports/*.xml'
            }
        }
        stage('Manual Approve') {
            input message: 'Lanjut ke tahap Deploy?'
        }
        stage('Deploy') {
            sh './jenkins/scripts/deliver.sh'
            sleep time: 1, unit: 'MINUTES'
        }
    }
}