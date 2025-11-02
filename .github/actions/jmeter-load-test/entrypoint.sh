#!/bin/bash
set -e

# Install Java
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk wget unzip

# Install JMeter
wget https://downloads.apache.org/jmeter/binaries/apache-jmeter-5.7.1.zip
unzip apache-jmeter-5.7.1.zip
sudo mv apache-jmeter-5.7.1 /opt/jmeter
export PATH=$PATH:/opt/jmeter/bin

# Run JMeter test
/opt/jmeter/bin/jmeter -n \
  -t .github/actions/jmeter-load-test/load-test.jmx \
  -l jmeter-results.jtl \
  -j jmeter.log

# Convert JMeter JTL to summary stats
AVG=$(awk -F',' 'NR>1 {sum+=$2; count++} END {print sum/count}' jmeter-results.jtl)
P90=$(awk -F',' 'NR>1 {a[NR]=$2} END {n=asort(a); print a[int(n*0.9)]}' jmeter-results.jtl)
P95=$(awk -F',' 'NR>1 {a[NR]=$2} END {n=asort(a); print a[int(n*0.95)]}' jmeter-results.jtl)
FAIL_RATE=$(awk -F',' 'NR>1 {if($8!=200) fail++} END {print (fail/NR)*100}' jmeter-results.jtl)
REQ_PER_SEC=$(awk -F',' 'NR>1 {count++} END {print count/15}') # assuming 15s duration

echo "JMeter summary: AVG=$AVG, P90=$P90, P95=$P95, FAIL_RATE=$FAIL_RATE%, REQ/s=$REQ_PER_SEC"

# Export variables for next action
echo "AVG=$AVG" >> $GITHUB_ENV
echo "P90=$P90" >> $GITHUB_ENV
echo "P95=$P95" >> $GITHUB_ENV
echo "FAIL_RATE=$FAIL_RATE" >> $GITHUB_ENV
echo "REQ_PER_SEC=$REQ_PER_SEC" >> $GITHUB_ENV
