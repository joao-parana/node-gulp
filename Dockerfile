# SO base: Debian Jessie

FROM node:6.9.1-onbuild

# The image ode:6.9.1-onbuild makes building derivative images easier. 
# So I'm using this aproach here. For most use cases, 
# creating a Dockerfile in the base of your project directory with the 
# line FROM node:onbuild will be enough to create a stand-alone image for 
# your project.
# 
# While the onbuild variant is really useful for "getting off the ground 
# running" (zero to Dockerized in a short period of time), it's not recommended 
# for long-term usage within a project due to the lack of control over when 
# the ONBUILD triggers fire (see also docker/docker#5714, docker/docker#8240, docker/docker#11917).
# 
# Once you've got a handle on how your project functions within Docker, 
# you'll probably want to adjust your Dockerfile to inherit from a 
# non-onbuild variant and copy the commands from the onbuild variant 
# Dockerfile (moving the ONBUILD lines to the end and removing the ONBUILD 
# keywords) into your own file so that you have tighter control over them 
# and more transparency for yourself and others looking at your Dockerfile 
# as to what it does. This also makes it easier to add additional requirements 
# as time goes on (such as installing more packages before performing the 
# previously-ONBUILD steps).


MAINTAINER João Antonio Ferreira "joao.parana@gmail.com"

# RUN groupadd -r node && useradd -r -g node node

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

# RUN set -x \
#   && curl -fSL "$APP_TGZ_URL" -o app.tar.gz \
#   && tar -xvf app.tar.gz --strip-components=1 \
#   && rm app.tar.gz*

RUN npm install -g bower && npm install -g polymer-cli && npm install -g gulp-cli

WORKDIR $APP_HOME
EXPOSE 8080
EXPOSE 80
EXPOSE 22

VOLUME $APP_HOME

CMD [ "bash" ]

# CMD ["sh", "~/bin/start.sh", "Iniciando Node JS e a Aplicação"]

