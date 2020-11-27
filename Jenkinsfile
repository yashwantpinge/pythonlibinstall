pipeline {
    agent {
        label 'master'
    }
    options {
        disableConcurrentBuilds()
    } 
    environment {
        docker_name = "pythoninstaller"
        github_id = '0413fe8f-8d71-4e82-9641-73509f51b1e7'

    }

    stages {
        stage('CloneTool') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: github_id,
                        usernameVariable: 'github_user',
                        passwordVariable: 'github_password',
                    ),
                ]){
                    echo "CloneTool"
                }
            }
        }
        stage('Build') {
            steps {
                bat "docker build --target=base --network=host -t ${env.docker_name}:base ."
                bat "mkdir ${WORKSPACE}\\output"
            }
        }
        stage('Packing') {
            when {
                 env.gitlabBranch 'main' 
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
                branch 'main'
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
