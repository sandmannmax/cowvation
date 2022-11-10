FROM python:3.7.6

WORKDIR /usr/src/app

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update && apt-get install -y --no-install-recommends \
        tzdata \
        python3-setuptools \
        python3-pip \
        python3-dev \
        python3-venv \
        git \
#        postgresql-dev \
        gcc \
        musl-dev \
        netcat \
#        dos2unix \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# install environment dependencies
RUN pip3 install --upgrade pip
RUN pip3 install pipenv

COPY ./Pipfile /usr/src/app/Pipfile
# Install project dependencies
RUN pipenv install --skip-lock --system --dev

COPY ./entrypoint.sh /usr/src/app/entrypoint.sh

#RUN dos2unix /usr/src/app/entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

COPY . /usr/src/app

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
