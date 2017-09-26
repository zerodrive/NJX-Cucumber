# For this example we take an Ubuntu image as basis.
FROM ubuntu:16.04

# This is optional. There are many other LABELs possible.
LABEL maintainer "thomas.schwade@zerodrive.net"

# Create a user.
# We will install our sample test project in this user's home directory.
RUN useradd -ms /bin/bash sag && \
    echo 'sag:sag' | chpasswd
WORKDIR /home/sag

# Install Ruby and some other modules we need for Cucumber.
RUN apt-get update
RUN apt-get install ruby --assume-yes
RUN apt-get install ruby-bundler --assume-yes
RUN apt-get install ruby-dev --assume-yes
RUN apt-get install build-essential --assume-yes
RUN apt-get install zlib1g-dev --assume-yes
RUN apt-get install libfontconfig --assume-yes
RUN ruby -v

# Install PhantomJS (a headless browser based on webkit).
RUN apt-get install wget --assume-yes
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xjf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN mv phantomjs-2.1.1-linux-x86_64 /opt/phantomjs
RUN ln -s /opt/phantomjs/bin/phantomjs /usr/local/bin/phantomjs
RUN phantomjs -v

# Install the Ruby gems we need to run Cucumber/Capybara/poltergeist
COPY Gemfile /home/sag
RUN bundle install

# Initialize the default Cucumber directory structure.
RUN cucumber --init

# Copy some test scenarios to the project directory.
# Feel free to adapt these to your needs or add more scenarios.
# Do not forget to adapt the URL in calculator_steps.rb first.
COPY calculator.feature /home/sag/features
COPY calculator_steps.rb /home/sag/features/step_definitions

# Now you can build the container with:
# sudo docker build -t mycucumber .

# After that, run the tests with:
# sudo docker run -it mycucumber cucumber











