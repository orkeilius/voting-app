FROM python:3.14.0a5-alpine3.21


RUN pip install redis flask requests
RUN apk add --no-cache gcc musl-dev linux-headers


COPY ./azure-vote .

EXPOSE 5000
EXPOSE 80
ENV FLASK_APP=main.py
ENV REDIS=redis
ENV REDIS_PWD=value


HEALTHCHECK --interval=1m --timeout=30s --retries=3 CMD curl --fail http://localhost:5000 || exit 1

CMD ["flask", "run", "--host=0.0.0.0", "--port=80"]