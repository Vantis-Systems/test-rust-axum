FROM rust:1.82-alpine AS builder
RUN apk add --no-cache musl-dev
WORKDIR /app
COPY Cargo.toml ./
COPY src ./src
RUN cargo build --release

FROM alpine:3.20
RUN adduser -D -u 1000 app
WORKDIR /app
COPY --from=builder /app/target/release/test-rust-axum .
USER 1000
EXPOSE 8080
CMD ["./test-rust-axum"]
