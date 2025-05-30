# Stage 1: Build
FROM golang:1.23-alpine3.21 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

# Stage 2: Run
FROM alpine:3.21
WORKDIR /app
COPY --from=builder /app/main .
COPY app.env .

EXPOSE 8080
CMD ["/app/main"]