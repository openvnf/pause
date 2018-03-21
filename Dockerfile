FROM alpine
ADD bin /bin
ENTRYPOINT ["/bin/pause"]
