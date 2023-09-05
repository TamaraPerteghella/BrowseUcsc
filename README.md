# BrowseUcsc

# Basic requirements:
## MacOS
The Safari seach engine is required.

## Linux
Firefox or Google chrome search engines are required.

# Usage
The `process_bed.py` takes in input a bed file to build the urls of interest. The code of the assembly to use shall be stated as second argument.
```
python3 process_bed.py test.bed hg38
```

This will produce an output file named `display_ucsc.urls.txt`, which can be passed to the `browse_ucsc.sh` script for automathic display as follows.
```
./browse_ucsc.sh display_ucsc.urls.txt
```

The tracks will be displayed on the basis of the cookies associated to the current session. Every change performed in the initial view will be therefore perpetuated to the following searches.
The indexes of the different genomic locations can be traced using:
```
grep "#" display_ucsc.urls.txt | cut -d"," -f1 | uniq -c | awk '{sum+=$1;$1=sum}1' | less
```
