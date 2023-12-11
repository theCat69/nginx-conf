NGINX_CONF_PATH='/etc/nginx'
NGINX_SCRIPTS_PATH='/home/nginx/scripts'

pipeline {
  agent any
    stages {
      // stage('Deployment') {
      //   steps {
      //     sh "${NGINX_SCRIPTS_PATH}/deploy_nginx_conf.sh"  
      //   } 
      // }
      stage('Test') {
        steps {
          sh "${NGINX_SCRIPTS_PATH}/test_conf.sh"
        }
      }
      stage('Restart') {
        steps {
          echo 'No restart because of previous failure'
        }
      }
    }
}
