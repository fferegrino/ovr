The overviewer but dockerised! 
==============================

A dockerised version of [The Minecraft Overviewer](http://docs.overviewer.org/en/latest/).

Just put your world into a folder called `world` in this directory, modify the `render-config.py` file to your needs and then build the image with:

```shell script
docker build . -t ovr
```

When you are ready, run the image with:

```shell script
docker run -it --rm -v $pwd/world:/tmp/world -v $pwd/output:/tmp/output ovr sh render.sh
```
