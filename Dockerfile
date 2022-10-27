FROM python:3.8.12-alpine3.13 as python

# We'll build/install all python dependencies in the python image
COPY requirements/prod.txt ./
RUN apk add --virtual build-deps \
    build-base \
    postgresql-dev \
    python3-dev \
    libffi-dev \
  && pip3 install --no-cache-dir -U pip \
  && pip3 install --no-cache-dir -r prod.txt \
  && apk del build-deps


FROM metabase/metabase:v0.44.2

# Copy the python binaries and libraries from the python image
# The metabase image is based on a newer alpine and the python package there 
# won't point to the exact version we need.
COPY --from=python /usr/local/bin/python3 /usr/local/bin/python3
COPY --from=python /usr/local/bin/python3.8 /usr/local/bin/python3.8
COPY --from=python /usr/local/bin/python /usr/local/bin/python

COPY --from=python /usr/local/lib/python3.8 /usr/local/lib/python3.8
COPY --from=python /usr/local/lib/libpython3.8.so.1.0 /usr/local/lib/libpython3.8.so.1.0
COPY --from=python /usr/local/lib/libpython3.so /usr/local/lib/libpython3.so


# We need to install some package that are not present in the metabase image
RUN apk add libpq

# Create the report user, group, home directory and package directory.
RUN addgroup -S report \
  && adduser -S -G report -h /var/lib/report report
WORKDIR /var/lib/report


# Copy the rest of the python application files.
COPY . .

ENV PYTHONPATH /var/lib/report:$PYTHONPATH
