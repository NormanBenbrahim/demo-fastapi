# https://hub.docker.com/r/tiangolo/uvicorn-gunicorn/
FROM tiangolo/uvicorn-gunicorn:python3.7

# Allow statements and log   messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME /container_image
WORKDIR $APP_HOME
COPY . ./

RUN apt-get update -y
RUN apt-get -y install gcc

# dependencies
RUN pip install --no-cache-dir --use-feature=2020-resolver -r requirements.txt

# run the app
CMD exec gunicorn -k uvicorn.workers.UvicornWorker --bin :$PORT --workers 4 --threads 8 --timeout 0 app:app