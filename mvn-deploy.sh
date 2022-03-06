mvn deploy:deploy-file \
-Durl=file:///mnt/c/Users/Janekdererste/Projects/openmpi-mvn-repo/ \
-Dfile=/mnt/c/Users/Janekdererste/Downloads/openmpi-4.1.2/ompi/mpi/java/java/mpi.jar \
-DgroupId=org.openmpi \
-DartifactId=mpi \
-Dpackaging=jar \
-Dversion=4.1.2
