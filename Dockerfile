FROM python:3.9-slim

RUN apt update -y && apt install -y curl \
    &&  curl -sL https://github.com/openfaas/faas/releases/download/0.9.14/fwatchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog

ENV fprocess="python entrypoint.py"
RUN useradd --create-home appuser
USER appuser

WORKDIR /home/appuser

COPY entrypoint.py /

RUN pip install requests

EXPOSE 8080
CMD [ "fwatchdog" ]