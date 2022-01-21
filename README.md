# graphs_for_pager
Auto-generating of the graphs used in my paper



Install the requirements

```bash
sudo apt-get update -y
sudo apt-get install -y make wget curl cloc graphviz librsvg2-bin  # graphviz and libsvg is necessary
pip install plantumlcli  # python should be 3.6 or higer version
```



Check the requirements

```bash
make -v
dot -v
rsvg-convert -v
plantumlcli -v
plantumlcli -c  # make sure plantumlcli is runnable
```



Then have fun with it

```bash
make build  # build all the graph to png, svg and pdf format
make clean  # clean all the build dists
```

