# Build stage (Force refresh: 3)
FROM alpine:latest as builder

# Install build dependencies
RUN apk add --no-cache curl tar xz git musl-dev

# Download and install Zig 0.15.2 (Stable release)
RUN curl -L https://ziglang.org/download/0.15.2/zig-linux-x86_64-0.15.2.tar.xz -o zig.tar.xz && \
    mkdir /zig && tar -xf zig.tar.xz -C /zig --strip-components=1 && \
    mv /zig/zig /usr/local/bin/zig && \
    mv /zig/lib /usr/local/lib/zig

WORKDIR /app
COPY . .

# Build the project
RUN zig build -Doptimize=ReleaseSmall

# Final stage
FROM alpine:latest
RUN apk add --no-cache libc6-compat sqlite-libs

# Create a non-root user
RUN adduser -D nullclaw
USER nullclaw
WORKDIR /home/nullclaw

# Copy the binary and entrypoint
COPY --from=builder /app/zig-out/bin/nullclaw /usr/local/bin/nullclaw
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# HF Spaces listens on port 7860 by default
EXPOSE 7860

# Port and other env vars (HF sets PORT=7860)
ENV PORT=7860
ENV HOME=/home/nullclaw

# Start using the entrypoint script
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
