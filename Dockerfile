# Use an official Python runtime as a parent image
ARG SMI_FROM_LATEST_MINOR_PYTHON=dockerhub.cisco.com/smi-fuse-docker-internal/smi-libraries/releases/python/3.8.27/python:3.8.27
ARG SMI_FROM_LATEST_MINOR_CN_UBUNTU=dockerhub.cisco.com/smi-fuse-docker-internal/mobile-cnat-cn/ubuntu-base/20.04/ubuntu-base:20.04.27-0027-5089e1c
ARG SMI_FROM_LATEST_PATCH_GOLANG=dockerhub.cisco.com/smi-fuse-docker-internal/smi-libraries/releases/golang/1.21.13.0/golang:1.21.13.0


FROM ${SMI_FROM_LATEST_MINOR_PYTHON} as python_builder

# Set the working directory in the container
WORKDIR /usr/src/app

RUN mkdir -p pythonfiles

# Copy the current directory contents into the container at /usr/src/app
COPY pythonfiles /usr/src/app/pythonFiles

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Run app.py when the container launches
##CMD ["python", "./app.py"]


FROM ${SMI_FROM_LATEST_PATCH_GOLANG}

# Set the working directory in the container
WORKDIR /usr/src/app

RUN mkdir -p gofiles 

COPY gofiles  /usr/src/app/gofiles

FROM ${SMI_FROM_LATEST_MINOR_CN_UBUNTU}

WORKDIR /usr/src/app

COPY --from=python_builder /usr/src/app/pythonFiles/*.py /usr/local/bin/

RUN chmod +x /usr/local/bin/*.py

COPY run-app /usr/local/bin/


