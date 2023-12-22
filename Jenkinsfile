JENKINS_SCRIPTS = 'jenkins-scripts'
SHOULD_ROLLBACK_IF_FAIL = false

void setBuildStatus(String message, String state) {
  step([
      $class: 'GitHubCommitStatusSetter',
      reposSource: [$class: 'ManuallyEnteredRepositorySource', url: "${env.GIT_URL}"],
      contextSource: [$class: 'ManuallyEnteredCommitContextSource', context: 'ci/jenkins/build-status'],
      errorHandlers: [[$class: 'ChangingBuildStatusErrorHandler', result: 'UNSTABLE']],
      statusResultSource: [ $class: 'ConditionalStatusResultSource', results: [[$class: 'AnyBuildResult', message: message, state: state]] ]
  ])
}

pipeline {
  agent any
  environment {
    NGINX_CONF_PATH = '/etc/nginx'
  }
  stages {
    stage('Deployment') {
      steps {
        sh "chmod -R 775 ${JENKINS_SCRIPTS}"
        sh "./${JENKINS_SCRIPTS}/deploy_nginx_conf.sh"
        script {
          SHOULD_ROLLBACK_IF_FAIL = true
        }
      }
    }
    stage('Restart') {
      steps {
        sh "./${JENKINS_SCRIPTS}/restart_nginx.sh"
      }
    }
    stage('Test') {
      steps {
        script {
          def output = sh(returnStdout: true, script: 'curl -I https://thecatmaincave.com/')
          def code = output.tokenize()[1]
          echo "return code : ${code}"
          if (code != '200') {
            error('Nginx is down or dont behave properly')
          }
        }
      }
    }
  }
  post {
    unsuccessful {
      script {
        echo 'Something went wrong'
        if (SHOULD_ROLLBACK_IF_FAIL) {
          echo 'Error during pipeline rollbacking ...'
          sh "./${JENKINS_SCRIPTS}/restore_backup.sh"
          sh "./${JENKINS_SCRIPTS}/restart_nginx.sh"
          echo 'Rollback and restart done'
        } else {
          echo 'No rollback for this build'
        }
        setBuildStatus('Failure', 'FAILURE')
      }
    }
    success {
      script {
        setBuildStatus('Success', 'SUCCESS')
      }
    }
  }
}
