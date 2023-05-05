import pickle
import sys

#BED file containing the coordinates to display
coordinates = open(sys.argv[1], "r")
links = open("display_ucsc.urls.txt", "w")
db = sys.argv[2]

for line in coordinates:
  try:
    chr = line.split("\t")[0]
    start = min(line.split("\t")[1], line.split("\t")[2])
    end = max(line.split("\t")[1],line.split("\t")[2])
    key = line.split("\t")[3]
    
    header = "#{0},position={1}:{2}-{3}".format(key, chr, start, end)
    urls = "http://genome.ucsc.edu/cgi-bin/hgTracks?db={0}&position={1}:{2}-{3}".format(db, chr, start, end)
    links.write(header + "\n" + urls + tracks + "\n")
  except e:
    print("Unexpected file format. BED file supported.")

links.close()
