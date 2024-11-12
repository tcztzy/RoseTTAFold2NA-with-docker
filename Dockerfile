FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel
WORKDIR /app
COPY RF2na-linux.yml /app/RF2na-linux.yml
RUN conda env create -f RF2na-linux.yml && conda activate RF2NA
COPY SE3Transformer/ /app/SE3Transformer/
WORKDIR /app/SE3Transformer
RUN apt-get update && apt-get install -y git
RUN conda run -n RF2NA python -m pip install --no-cache-dir -r requirements.txt
RUN conda run -n RF2NA python setup.py install
COPY example/ /app/example/
COPY input_prep/ /app/input_prep/
COPY network/ /app/network/
RUN echo "source activate RF2NA" > ~/.bashrc
ENV PATH /opt/conda/envs/RF2NA/bin:$PATH
