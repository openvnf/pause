FROM golang:1.15.2-alpine3.12 AS builder

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git make

COPY . /build
WORKDIR /build
RUN make PLATFORM=linux

FROM alpine:3.12

COPY --from=builder /build/_build/bin/pause /bin/pause
ENTRYPOINT ["/bin/pause"]
