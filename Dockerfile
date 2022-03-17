FROM golang:alpine as builder
WORKDIR /build/app
# Get depedences
RUN apk add --no-cache git
COPY go.mod ./
RUN go mod download
COPY . .
# Build app
RUN go build -o app
FROM alpine
COPY --from=builder /build/app/app ./app
ENTRYPOINT ["./app"]

EXPOSE 8080
