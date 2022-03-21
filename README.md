# Maven Repo for Open-MPI Java Bindings
This Git-Repo contains a Maven-Repo 🙃 to serve Binaries of the Open-Mpi Java Bindings for depending projects.

## Why
The system one wants to run on must contain an installation of Open-MPI with Java-Bindings enabled. In this case one 
can simply build a Java-Program with the MPI library as a dependency, deploy it on the target system and run it with the 
```mpirun``` command. Unfortunately, the Java-MPI dependency is not available in a public Maven repository. Therefore, 
I created a maven repo which can be included into a Java Project

## Steps to produce this repository
First, one needs to compile Open-MPI to obtain a ```mpi.jar```. The following steps were necessary:

Download a recent Open-Mpi [tar-all](https://www.open-mpi.org/software/ompi/v4.1/).

Follow the [instrcutions](https://github.com/open-mpi/ompi/blob/master/docs/installing-open-mpi/quickstart.rst) from the open-mpi repo.
In the configure step one needs to follow the [java instructions](https://github.com/open-mpi/ompi/blob/master/docs/features/java.rst#building-the-java-bindings)
though. I used the following commands: 
```
$ tar xf openmpi-<version>.tar.bz2
$ cd openmpi-<version>
$ ./configure --prefix=<path/to/where/the/installation/should/go> --enable-mpi-java 
...lots of output...
$ make -j 8 
...lots of output...
$ make install
...lots of output...
```
This still gave errors and didn't finish, but run sufficiently far to have produced the necessary ```mpi.jar```

In case another Java version than the default one should be used, the ```./configure``` can be configured via ```--with-jdk-dir=/path/to/desired/jdk/```

After the previous step there should be a ```mpi.jar``` under ```openmpi-<version>/ompi/mpi/java/java```. 
```openmpi-<version>```Is the folder the tar ball was extracted into. This jar 
can be used as a dependency in a java program. It was deployed into this maven repository by using the command in the 
[deploy script](https://github.com/matsim-vsp/openmpi-mvn-repo/blob/master/mvn-deploy.sh)

Unfortunately, I figured out later, that one can't simply download things from there. Therefore I put the prduced artifacts
into an [AWS-Bucket](https://openmpi-java-bindings.s3.eu-central-1.amazonaws.com/)

## Include this in a maven build
To include the dependency in your maven build, add this repository to the list of repositories:
```
<repository>
    <id>Open-MPI</id>
    <name>VSP Repo for the MPI Java Binings</name>
    <url>https://openmpi-java-bindings.s3.eu-central-1.amazonaws.com/</url>
</repository>
```
Then add a dependency
```
<dependency>
    <groupId>org.openmpi</groupId>
    <artifactId>mpi</artifactId>
    <version>4.1.2</version>
</dependency>
```
