FROM python:3
ENV PYTHONUNBUFFERED 1

# Add repos
RUN wget -O /etc/apt/sources.list.d/perfsonar-jessie-4.0.list http://downloads.perfsonar.net/debian/perfsonar-jessie-4.0.list
RUN wget -qO - http://downloads.perfsonar.net/debian/perfsonar-debian-official.gpg.key | apt-key add -
RUN wget https://downloads.globus.org/toolkit/gt6/stable/installers/repo/deb/globus-toolkit-repo_latest_all.deb

RUN apt-get update
RUN apt-get install apt-transport-https

RUN dpkg -i ./globus-toolkit-repo_latest_all.deb
RUN apt -yf install
RUN dpkg -i ./globus-toolkit-repo_latest_all.deb
RUN apt update
RUN apt -y install git perfsonar-tools globus-gridftp python-pip

RUN useradd -ms /bin/bash gridftp 
RUN mkdir /data
RUN chown gridftp /data

ADD ./gridftp.conf /etc/gridftp.conf
ADD ./start.sh .

CMD "./start.sh"
