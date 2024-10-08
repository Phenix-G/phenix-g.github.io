# 使用官方 Node.js 18 镜像作为基础镜像
FROM node:18-alpine

# 设置工作目录
WORKDIR /app

# 将 package.json 和 package-lock.json 复制到工作目录
COPY package.json ./
COPY *.lock ./

# 安装依赖
RUN yarn 
# 将应用程序代码复制到工作目录
COPY . .
