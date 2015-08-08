# Shootout

Performance measurement for JSON encoder/decoders.

This is a rough test.  Three runs were done for each library on the same machine around the same time.  Still there was
some observed variability in the results on the order of up to %30.  A more controlled experiment involving many more runs 
and more variance in the data used for the test is necessary for real performance benchmarks. 

All test data from: http://www.json-generator.com  All the tests were run on the same 500k JSON file.  The structure of this 
file may affect speeds significantly. 

### Usage

```shell
	$ mix do shootout.run
	$ ...
```
