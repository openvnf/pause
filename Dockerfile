FROM alpine:3.12
ADD bin /bin
ENTRYPOINT ["/bin/pause"]
