# graphs_for_pager
Auto-generating of the graphs used in my paper



Install the requirements

```bash
sudo add-apt-repository -y ppa:inkscape.dev/stable
sudo apt-get update -y
sudo apt-get install -y make wget curl cloc graphviz librsvg2-bin inkscape  # graphviz and inkscape is necessary
pip install plantumlcli  # python should be 3.6 or higer version
```



Check the requirements

```bash
make -v
dot -v
rsvg-convert -v
inkscape -V
plantumlcli -v
plantumlcli -c  # make sure plantumlcli is runnable
```



Then have fun with it

```bash
make build  # build all the graph to png, svg and pdf format
make clean  # clean all the build dists
```

