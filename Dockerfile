FROM ruby:2.6.5

# Install nodejs as required by Rail assets pipeline
RUN apt-get -y update \
    && apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs mariadb-server \
    && npm install --global yarn \
    && gem install rails 

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# Create and set working directory to /course
# Also doubles as the volumne which will get mapped to the appropriate directory
WORKDIR /simple-cms

# Expose port 3000 
EXPOSE 3000
