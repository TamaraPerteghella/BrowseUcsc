# BrowseUcsc

# Basic requirements:
## MacOS
The Safari seach engine is required.

## Linux
Firefox or Google chrome search engines are required.

# Usage
The `process_bed.py` takes in input a bed file to build the urls of interest.
`python3 process_bed.py test.bed hg38`

This will produce an output file named `display_ucsc.urls.txt`, which can be passed to the `browse_ucsc.sh` script for automathic display as follows.
`./browse_ucsc.sh display_ucsc.urls.txt`

The tracks will be displayed on the basis of the cookies associated to the current session. Every change performed in the initial view will be therefore perpetuated to the following searches.
