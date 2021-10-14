node {
    stage('Validate') {
        checkout([$class: 'GitSCM', branches: [[name: '**']], extensions: [], userRemoteConfigs: [[url: 'http://gitlab.local:90XX/sketch/lbpostgresshared.git']]])
        sh '''liquibase tag $BUILD_NUMBER
              liquibase status --verbose'''
    }
    stage('Update') {
        sh '''liquibase updateSQL
              liquibase update'''
    }
    stage('Rollback') {
        sh '''liquibase rollbackSQL $BUILD_NUMBER
              liquibase rollback $BUILD_NUMBER'''
    } 
    stage('Finalize') {
        sh '''liquibase update'''
    }          
    stage('Snapshot') {
        sh '''liquibase --outputFile=snapshot_$BUILD_NUMBER.json snapshot --snapshotFormat=json
              mv snapshot_$BUILD_NUMBER.json /var/jenkins_home/snapshots/snapshot_$BUILD_NUMBER.json'''
    }    
}
