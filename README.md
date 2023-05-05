# BrowseUcsc

# Basic requirements:
## MacOS
## Linux


# Usage
The process_bed.py takes in input a bed file to build the urls of interest.
python3 process_bed.py test.bed hg38

This will produce an output file named display_ucsc.urls.txt, which can be passed to the browser.sh script for automathic display as follows.
./browser.sh display_ucsc.urls.txt

