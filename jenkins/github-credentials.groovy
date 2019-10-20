import com.cloudbees.plugins.credentials.impl.*;
import com.cloudbees.plugins.credentials.*;
import com.cloudbees.plugins.credentials.domains.*;
import hudson.model.*

Credentials c = (Credentials) new UsernamePasswordCredentialsImpl(CredentialsScope.GLOBAL,"github", "GitHub Credentials", "FlorianSeidel", System.getenv("GITHUB_PW"))

SystemCredentialsProvider.getInstance().getStore().addCredentials(Domain.global(), c)