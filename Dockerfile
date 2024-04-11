# syntax=docker/dockerfile:1

FROM golang:1.22.2

ENV PORT=3000


WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o trust-wallet-gateway


EXPOSE ${PORT}

CMD ["/app/trust-wallet-gateway"]