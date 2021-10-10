#!/bin/bash

for i in $(eval echo {1..$1}); do
	echo Test.$i > Test.$i.txt
done
