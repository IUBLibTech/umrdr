FROM phusion/passenger-ruby24:0.9.29

RUN apt-get update && apt-get install -y libreoffice imagemagick sqlite unzip

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

WORKDIR /tmp
WORKDIR /usr/local
RUN curl -O http://projects.iq.harvard.edu/files/fits/files/fits-0.8.5.zip && unzip fits-0.8.5.zip && chmod +x /usr/local/fits-0.8.5/fits.sh
ENV PATH=$PATH:/usr/local/fits-0.8.5/:/usr/local/rvm/gems/ruby-2.4.3/bin/
RUN apt-get install -y iputils-ping telnet


WORKDIR /home/app
RUN mkdir /home/app/hyrax
RUN gem install rails:5.0.6
WORKDIR /home/app/hyrax
COPY . /home/app/hyrax
RUN chown -R app:app .
RUN mkdir /home/app/hyrax/data
RUN chown app:app /home/app/hyrax/data
USER app
RUN bundle install
#RUN rails generate hyrax:work Work
#RUN nohup rake hydra:server &
#RUN rake hyrax:workflow:load
#RUN rake hyrax:default_admin_set:create

#CMD ["/sbin/my_init"]
#CMD ["rake","hydra:server"]
#CMD ["rails","s"]
#CMD ["sleep","600"]
