#!/bin/bash

set -x

### requirements ###
# the great tabula-java https://github.com/tabulapdf/tabula-java/wiki/Using-the-command-line-tabula-extractor-tool
# csvkit
### requirements ###

# to extract refugees and migrants data (1-52 pages)
java -jar /usr/local/bin/tabula-1.0.1-jar-with-dependencies.jar -a 203.959,33.394,939.649,796.826 -p 1-52 -o ./tmp/data_table_01.csv ./TheList.pdf

# to extract sources data (53-56 pages)
java -jar /usr/local/bin/tabula-1.0.1-jar-with-dependencies.jar -a 177.244,40.586,949.924,786.551 -p 53-56 -o ./tmp/data_table_02.csv ./TheList.pdf

cat ./resource/data_table_02_header.csv ./tmp/data_table_02.csv >./tmp/sources.csv
csvcut -c 1,2 ./tmp/sources.csv >./tmp/s12.csv
csvcut -c 3,4 ./tmp/sources.csv >./tmp/s34.csv
csvcut -c 5,6 ./tmp/sources.csv >./tmp/s56.csv

csvstack ./tmp/s12.csv ./tmp/s34.csv ./tmp/s56.csv >./data/sources.csv
cat ./resource/data_table_01_header.csv ./tmp/data_table_01.csv >./data/refugeesAndMigrants.csv
