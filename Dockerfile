# Dependencia: dockerfile/nodejs-bower-gulp-runtime
FROM dockerfile/nodejs-bower-gulp-runtime

# Responsável
MAINTAINER João Antonio Ferreira "joao.parana@gmail.com"

# This image assumes that your application:
# 
# has a file named package.json listing its dependencies.
# has a file named bower.json listing its dependencies.
# has a file named Gulpfile.js registering build task.
# has a file named server.js as the entrypoint script or define in package.json the attribute: "scripts": {"start": "node <entrypoint_script_js>"}
# listens on port 8080
# When building your application docker image, ONBUILD triggers install NPM module dependencies of your application using npm install.
# 
# Step 1: Create a Dockerfile in your Node.js application directory with the following content:
#   FROM dockerfile/nodejs-bower-gulp-runtime
#   Step 2: Build your container image by running the following command in your application directory:
#   docker build -t="app" .
# Step 3: Run application by mapping port 8080:
#   APP=$(docker run -d -p 8080 app)
#   PORT=$(docker port $APP 8080 | awk -F: '{print $2}')
#   echo "Open http://localhost:$PORT/"

# Install tomcat8
ENV APP_HOME     /app

ENV PATH $APP_HOME/bin:~/bin:$PATH

ENV APP_MAJOR 1
ENV APP_VERSION 1.0.0

RUN set -x \
  && curl -fSL "$APP_TGZ_URL" -o app.tar.gz \
  && tar -xvf app.tar.gz --strip-components=1 \
  && rm app.tar.gz*

WORKDIR $APP_HOME
EXPOSE 8080
EXPOSE 80
EXPOSE 22

# CMD ["sh", "~/bin/start.sh", "Iniciando Node JS e a Aplicação"]

