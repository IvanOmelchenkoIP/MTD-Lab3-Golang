FROM golang:1.17 AS builder

WORKDIR /app

COPY go.mod /app
COPY go.sum /app
RUN go mod download

COPY . /app

RUN CGO_ENABLED=0 go build -o ./build/fizzbuzz 

COPY . /app

FROM scratch

COPY --from=builder /app /

CMD ["./build/fizzbuzz", "serve"]