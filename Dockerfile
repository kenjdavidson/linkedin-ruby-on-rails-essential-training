FROM ruby:2.6.5

# Install nodejs as required by Rail assets pipeline
RUN apt-get update -qq \
    && apt-get install -y nodejs

# Create and set working directory to /course
# Also doubles as the volumne which will get mapped to the appropriate directory
WORKDIR /simple-cms

# Expose port 3000 
EXPOSE 3000
