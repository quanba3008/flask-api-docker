# FROM alpine:latest

# RUN apk update
# RUN apk add py-pip
# RUN apk add --no-cache python3-dev 
# RUN pip install --upgrade pip

# WORKDIR /app
# COPY . /app
# RUN pip --no-cache-dir install -r requirements.txt

# CMD ["python3", "app.py"]

FROM python:3.9-slim

# Cài đặt các công cụ cần thiết để tạo môi trường ảo
RUN apt-get update && apt-get install -y python3-venv

# Tạo môi trường ảo
RUN python3 -m venv /opt/venv

# Kích hoạt môi trường ảo và nâng cấp pip
RUN /opt/venv/bin/pip install --upgrade pip

# Cài đặt các gói cần thiết trong môi trường ảo
COPY requirements.txt .
RUN /opt/venv/bin/pip install -r requirements.txt

# Copy mã nguồn và thiết lập lệnh khởi chạy
COPY . /app
WORKDIR /app
EXPOSE 80
# Sử dụng môi trường ảo để chạy ứng dụng
CMD ["/opt/venv/bin/python", "app.py"]
