# Base image
FROM pytorch/pytorch:1.12.0-cuda11.3-cudnn8-devel

# Set args
ARG DEBIAN_FRONTEND=noninteractive

# Set temporary directory
WORKDIR /container

# Install base utilities
RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get install -y build-essential wget git nano vim ffmpeg libgl1-mesa-glx libglib2.0-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt /container/requirements.txt
RUN yes | pip install -r /container/requirements.txt

# Expose port
EXPOSE 4321

# Set directory
WORKDIR /workspace

# Run command as entrypoint: jupyter notebook --no-browser --allow-root --ip=0.0.0.0 --port=4321 --NotebookApp.token='' --NotebookApp.password=''
ENTRYPOINT [ "jupyter", "notebook", "--no-browser", "--allow-root", "--ip=0.0.0.0", "--port=4321", "--NotebookApp.token=''", "--NotebookApp.password=''" ]