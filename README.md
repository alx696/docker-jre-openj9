## 特点

* 基础镜像：[adoptopenjdk:11-jre-openj9](https://hub.docker.com/layers/adoptopenjdk/library/adoptopenjdk/11-jre-openj9/images/sha256-10ed35d723510fa10ee600eb903e4da24ae41b0da3710d2cb7815af55cc7b7c8?context=explore)
* 软源镜像：中国科学技术大学 mirrors.ustc.edu.cn
* 基础工具：wget, nano
* 中文时区：**Asia/Shanghai**
* 中文字体：**Noto Serif CJK SC** 样式**Regular**, 信息：`/usr/share/fonts/NotoSerifCJKsc-Regular.otf: Noto Serif CJK SC:style=Regular`

## 构建

```
$ docker build -t registry.cn-shanghai.aliyuncs.com/xm69/jre:openj9 .
```

## 测试

```
$ docker run -it --rm registry.cn-shanghai.aliyuncs.com/xm69/jre:openj9 java -version
```

## 使用

### 配置启动应用

将应用目录映射到容器中, 然后通过运行参数启动应用入口:
```
$ docker run -d --restart=always \
  -p 10000:6000 \
  -e POSTGRES_JDBC="jdbc:postgresql://172.17.0.1:10010" \
  -v ${PWD}/app:/app \
  --name "java-grpc" registry.cn-shanghai.aliyuncs.com/xm69/jre:openj9 \
  /app/bin/grpc
```
> 说明: `/app/bin/grpc`为应用入口.