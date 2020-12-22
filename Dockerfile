FROM adoptopenjdk:11-jre-openj9

ENV DEBIAN_FRONTEND="noninteractive"

# https://github.com/googlefonts/noto-cjk/raw/master/NotoSerifCJKsc-Regular.otf
ENV FONT_URL="https://file.lilu.red:444/font/NotoSerifCJKsc-Regular.otf"

RUN set -eux && \
  sed -i s/archive.ubuntu.com/mirrors.ustc.edu.cn/g /etc/apt/sources.list && \
  sed -i s/security.ubuntu.com/mirrors.ustc.edu.cn/g /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y apt-utils apt-transport-https && \
  # apt-get upgrade -y && \
  # 安装下载和编辑工具
  apt-get install -y wget nano && \
  # 时区设为上海(注意:必须删除/etc/localtime,否则对时区的修改不会生效!)
  apt-get install -y tzdata && \
  rm /etc/localtime && \
  echo "Asia/Shanghai" > /etc/timezone && \
  dpkg-reconfigure -f noninteractive tzdata && \
  # 安装中文字体:Noto Sans CJK SC Regular
  apt-get install -y fontconfig xfonts-utils && \
  mkdir -p /usr/share/fonts/ && \
  wget ${FONT_URL} --no-check-certificate -O /usr/share/fonts/NotoSerifCJKsc-Regular.otf && \
  fc-cache -f -v && \
  fc-list :lang=zh && \
  # 清理
  apt-get autoremove -y && \
  apt-get autoclean -y && \
  rm -rf /var/lib/apt/lists/* && \
  # 测试
  java -version
