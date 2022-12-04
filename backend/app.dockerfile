# escape=\
FROM python:3
# Install image dependencies
RUN apt-get update && apt-get install -y \
    apt-utils \
    gettext-base \
    wait-for-it \
&& rm -rf /var/lib/apt/lists/*
# Create application backend
RUN useradd -m -d /app backend
COPY . /app
RUN chmod +x /app/entrypoint.sh
# change backend config file
RUN envsubst < /app/backend.conf.template > /app/backend.conf
# Install application
WORKDIR /app
USER backend
RUN python3 -m pip install --user -r requirements.txt
# Program executable
ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "/app/.local/bin/gunicorn", "wsgi:app", "-b", "0.0.0.0:8000" ]