# polynote-docker by xtream

[Polynote](https://github.com/polynote/polynote) is a _polyglot_ notebook environment created by the Netflix Data Science team which allows seamless interaction between Python, Scala and SQL syntax.

We created this Docker image to allow us to experiment within the Polynote environment as well as with the other Data Science tool we normally use, without going through the hassle of a clean installation everytime.

# Packaged Tools 📦

The image contains the following tools:

* Python
    - pyspark
    - pandas
    - numpy
    - tensorflow
    - keras
    - matplotlib
    - plotly
* Scala
* Spark
* Polynote

# docker-compose 🛠

The `docker-compose.yml` file allows you to install everything with the blink of an eye through the help of the `docker-compose` tool.

Just clone the repository, `cd` into it, and run:

```
docker-compose up -d
```

This will also do two important things:

* it will map the port 8192 of the container to the port 8192 of the host
* it will mount the `/data` folder of the host at the `/data` folder of the container to allow you to use your datasets.


Otherwise you can just run:

```
docker run -d -v /data:/data -p 8192:8192 xtream/polynote-docker
```

# Access Polynote ✔️

Just go to:

```
<docker-machine-ip>:8192
```
That's it. 😀
