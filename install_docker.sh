#!/bin/bash

set -e

echo "=== Cập nhật hệ thống ==="
sudo apt-get update
sudo apt-get upgrade -y

echo "=== Cài đặt gói phụ thuộc ==="
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "=== Thêm Docker GPG key ==="
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "=== Thêm Docker repository ==="
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Cập nhật lại danh sách gói và cài Docker ==="
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== Kích hoạt Docker và thêm user vào nhóm docker ==="
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

echo "=== Kiểm tra phiên bản Docker và Docker Compose ==="
docker --version
docker compose version

echo "=== ✅ Cài đặt hoàn tất! Vui lòng đăng xuất và đăng nhập lại để dùng docker không cần sudo. ==="
