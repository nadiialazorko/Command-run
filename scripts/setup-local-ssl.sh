#!/usr/bin/env bash
set -e

# based on next.js solution
# currently supporting only linux/macos

mkcert_version="v1.4.4"
bin_path=".dev/mkcert"
uname=`uname -a`
platform=""
arch=""

if [[ "$uname" == "Linux"* ]]; then
  platform="linux"
elif [[ "$uname" == "Darwin"* ]]; then
  platform="darwin"
fi

echo "Detected platform: ${platform}"

if [[ "$uname" == *"x86_64"* ]]; then
  arch="amd64"
elif [[ "$uname" == *"arm64"* ]]; then
  arch="arm64"
fi

echo "Detected arch: ${arch}"

if [[ "$platform" == "" || "$arch" == "" ]]; then
  echo "Wrong platform/arch: ${platform}/${arch}"
  exit 0;
fi

if [ ! -f "$bin_path" ]; then
    name="https://github.com/FiloSottile/mkcert/releases/download/${mkcert_version}/mkcert-${mkcert_version}-${platform}-${arch}"
    echo "Downloading ${name}..."
    wget $name -O "$bin_path"
    chmod +x .dev/mkcert
fi

# installs CA in the certificate stores
.dev/mkcert -install -key-file ".dev/self-signed.key" -cert-file ".dev/self-signed.crt" localhost 127.0.0.1 ::1
