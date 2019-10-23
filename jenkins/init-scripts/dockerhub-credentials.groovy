import com.cloudbees.plugins.credentials.impl.*;
import com.cloudbees.plugins.credentials.*;
import com.cloudbees.plugins.credentials.domains.*;
import hudson.model.*

Credentials c = (Credentials) new UsernamePasswordCredentialsImpl(CredentialsScope.GLOBAL,"dockerhub", "DockerHub Credentials", "florianseidel", System.getenv("DOCKERHUB_PW"))

SystemCredentialsProvider.getInstance().getStore().addCredentials(Domain.global(), c)