FROM docker-0.unsee.tech/debian:bullseye

# 替换为清华大学镜像源（或保留官方源）
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list

# 安装 GPG 密钥工具和 wget
RUN apt-get update && apt-get -y install gnupg wget

# 添加 LLVM 的 APT 源
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-14 main" > /etc/apt/sources.list.d/clang.list

# 安装依赖，包括 OpenGL 和 SDL2
RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
        clang-14 lldb-14 lld-14 ca-certificates \
        autoconf automake cmake dpkg-dev file git make patch \
        libc-dev libc++-dev libgcc-10-dev libstdc++-10-dev \
        dirmngr gnupg2 lbzip2 wget xz-utils libtinfo5 \
        # OpenGL 依赖
        libgl1-mesa-dev libglu1-mesa-dev mesa-common-dev \
        # SDL2 依赖
        libsdl2-dev && \
    rm -rf /var/lib/apt/lists/*

# 复制项目文件
ADD . /typerunner
WORKDIR /typerunner

# 构建项目
RUN mkdir build
RUN cd build && cmake -DCMAKE_CXX_COMPILER=clang++-14 -DCMAKE_C_COMPILER=clang-14 -DCMAKE_BUILD_TYPE=Release ..
RUN cd build && make bench typescript_main -j 8

# 运行测试
CMD ./build/bench tests/objectLiterals1.ts && \
    ./build/typescript_main tests/objectLiterals1.ts