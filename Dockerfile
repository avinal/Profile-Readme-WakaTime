FROM ubuntu:latest

# Add files to docker
ADD requirements.txt main.py entrypoint.sh colors.json /

# run update and install packages
RUN apt-get update && apt-get install -y git python3.8 python3-pip

# install requirements
RUN pip3 install -r requirements.txt

# grant permissions
RUN chmod +x entrypoint.sh

# run final script
CMD python3 /main.py && /entrypoint.sh