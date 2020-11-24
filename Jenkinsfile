pipeline {
    agent {
        label 'rndit'
    }
    options {
        disableConcurrentBuilds()
    } 
    environment {
        docker_name = "pythoninstaller"
        github_id = '74237803'
        build_results = "https://boss.corp.hpicloud.net/job/BPSValidation/job/BPSV%20Test%20Cases/job/test-case/job/dev/"

    }

    stages {
        stage('CloneTool') {lok
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: github_id,
                        usernameVariable: 'github_user',
                        passwordVariable: 'github_pass',
                    ),
                ])
            }
        }
        stage('Build') {
            steps {
                sh "docker build --target=base --network=host -t ${env.docker_name}:base ."
                sh "mkdir ${WORKSPACE}/output"
            }
        }
        stage('Packing') {
            when {
                branch 'dev'
            }
            steps {
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                    configFileProvider([configFile(fileId: 'bddc9fb1-26f8-425d-bc90-3dd0b5e7daeb', variable: 'token_file')]) {
                        sh "git diff --name-only ${GIT_COMMIT}..${GIT_PREVIOUS_SUCCESSFUL_COMMIT} > commit_diff.txt"
                        sh "cp ${token_file} ./token_file.json"
                        sh """
                            docker run --rm -v ${WORKSPACE}:/usr/src/docker \
                            -w /usr/src/docker \
                            ${env.docker_name}:base \
                            output/
                        """
                    }
                }
            }
        }
        stage('Deploy') {
            when {
                branch 'dev'
            }
            steps {
                sh """
                    docker run --rm -v ${WORKSPACE}:/usr/src/docker \
                    -w /usr/src/docker \
                    --network=host \
                    ${env.docker_name}:base \
  
                """
            }
        }
    }
    post {
        success {
            script {
                if ("${env.BRANCH_NAME}" == 'dev') {
                    
                }
            }
        }
    }
}
