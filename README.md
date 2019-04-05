# chemlambda-awk

A re-organization (and expected small modifications for best-practice purposes) of [chemlabda-gui](https://github.com/chorasimilarity/chemlambda-gui/blob/gh-pages/dynamic/README.md)

Please check the original repository for more details on the work of the author.

It is licensed similarly to the original repository, `chemlambda-gui`


## Usage

The `chemlambda_awk_single.sh` script is the main script for converting a single mol file through a awk file to html

```
Usage: /bin/sh chemlambda_awk.sh <input awk file> <input mol file> <output html file>
```

For example

```
/bin/sh chemlambda_awk_single.sh transform/quiner.awk mol/other/letbeta.mol html_out/letbeta.html
```

Note that if the target file is in a folder other than `html_out`, the libraries `d3.min.js` and `jquery.min.js` will also need to be copied.


The `chemlambda_awk_all.sh` script wraps the `chemlambda_awk_single.sh` to generate the catalog of simulations of all transform-mol file pairs.
The catalog is generated into `html_catalog` and it's supposed to be published to a public AWS S3 bucket for example.