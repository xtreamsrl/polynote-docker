FROM tiangolo/python-machine-learning:python3.6-tensorflow
LABEL maintainer="riccardo.maganza@xtreamers.io"

WORKDIR /usr/src/app

ENV SPARK_VERSION=2.4.4
ENV HADOOP_VERSION=2.7
ENV SCALA_VERSION=2.11.12
ENV POLYNOTE_VERSION=0.2.13


# Install OpenJDK
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Install Python and dependencies

RUN pip install jep
RUN conda install -y pyspark virtualenv keras plotly matplotlib seaborn scikit-learn scipy
RUN conda install -y -c conda-forge jedi chartify
RUN conda clean -y --all

RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
&& tar -zxvf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
&& mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
&& mv spark /opt/spark \
&& rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN wget -O- "https://www.scala-lang.org/files/archive/scala-${SCALA_VERSION}.tgz" \
    | tar xzf - -C /usr/local --strip-components=1

RUN wget -c https://www.zlib.net/fossils/zlib-1.2.9.tar.gz -O - | tar -xz  \
&& cd zlib-1.2.9 && ./configure && make && make install \
&& cd /lib/x86_64-linux-gnu && ln -s -f /usr/local/lib/libz.so.1.2.9/lib libz.so.1 \
&& cd ~ && rm -rf zlib-1.2.9

ENV SPARK_HOME=/opt/spark
ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"
ENV PYSPARK_ALLOW_INSECURE_GATEWAY=1

# Download and extract polynote
RUN curl -Lk https://github.com/polynote/polynote/releases/download/${POLYNOTE_VERSION}/polynote-dist.tar.gz \
  | tar -xzvpf -

RUN ln -s `which pip` /opt/conda/bin/pip3

RUN  rm -rf \
         /var/lib/apt/lists/* \
         /tmp/* \
         /var/tmp/* \
         /usr/share/man \
         /usr/share/doc \
         /usr/share/doc-base \
         /root/.cache/pip

COPY config.yml ./polynote/config.yml

EXPOSE 8192

CMD ["python", "polynote/polynote.py"]
