# chemlambda-awk
A re-write of [chemlabda-gui](https://github.com/chorasimilarity/chemlambda-gui/blob/gh-pages/dynamic/README.md)

Please check there for more info on the original work of the author

The purpose of the re-write is to organize the source code and separate it from the resultant html files

It is licensed similarly to `chemlambda-gui`


## Usage

The `chemlambda_awk.sh` script is the main script for converting a mol file through a awk file to html

```
Usage: /bin/sh chemlambda_awk.sh <input awk file> <input mol file> <output html file>
```

For example

```
/bin/sh chemlambda_awk.sh chemlambda_awk.sh transform/quiner.awk mol/other/letbeta.mol html_out/letbeta.html
```

Note that if the target file is in a folder other than `html_out`, the libraries `d3.min.js` and `jquery.min.js` will also need to be copied.