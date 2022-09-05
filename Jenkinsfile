pipeline {
   agent { node {label 'slave01'} }
   parameters {
       choice(
           name: 'Language' ,
           choices: ['All', 'Python', 'C', 'Bash']
       	     )
   	}
//      describtion: 'scripts in diffrent languages'


   stages {
      stage('Script language to run') {
         steps {
             script {
                if (Language == 'All' ) {
         echo 'running all scripts available'
            }
             else   {
          echo 'you choose to run only ${PARAMS.Language} script'
            }
        }
    }
}
  
	  stage('Bash') {
         steps {
             retry(1)
         {
             script {
                 if ((Language == 'Bash') || (Language == 'All'))
                {
                    sh '/bin/bash /home/jenkins-slave/Desktop/scripts/make_dir.sh'
                    sh 'ls -l ~/Desktop/DirA'
                    echo "Bash script was executed successfully"
                }     
            }
        }
    }
}

//          description: "Creating DirA in Desktop, making 1-5 txt files and inserting some text in it "

	  stage('Python') {
	      when { expression { Language == 'Python' || Language == 'All' } }
         steps {
             retry(1) {
                 sh  'python3 -u /home/jenkins-slave/Desktop/scripts/python_format_change.py'
                 sh 'ls -l ~/Desktop/DirA'
                    echo "Python script was executed successfully"
        }
    }
}
	  
//          description: 'changing file names and endings from *.txt to *.jpg in a simple format'
	  
	  
	  stage('C') {
	      when { expression { Language == 'C' || Language == 'All' } }
         steps {
             retry(1) {
                 sh  '/home/jenkins-slave/Desktop/scripts/hello'
                    echo "C script was executed successfully"
                }
            } 
	}
//              description: 'just a simple hello world in C'
	
stage('Saving Results') {
          steps {
            echo 'Saving Results process..'
            sh '''
	          report_file="${HOME}/Documents/report.txt"
              mkdir -p ${HOME}/Documents/Deployment/              
              if [ -f "${report_file}" ]; then
                echo "file ${report_file} exists"
              else
	              touch ${report_file}
              fi
	      date >> ${report_file}
	      echo "USER=$USER JOB_NAME=$JOB_NAME" >> ${report_file}
          echo "Build Number $BUILD_NUMBER" >> ${report_file}
	      echo "#############################" >> ${report_file}
            '''
         	}
	}
   }
   
   post {   
		always {
			sh 'printenv'   
		}   
		success {   
			sh 'echo "BUILD_NUMBER=$BUILD_NUMBER success" >> report' 
		}   
		failure {
			sh 'echo "BUILD_NUMBER=$BUILD_NUMBER failed" >> report'   
		}
	}
}
