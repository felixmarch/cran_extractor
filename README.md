# Cran Extractor

To pull the package and description data, run this command:
```$ ./cran.rb
```

The package number limit can be changed at variable MAX_PACKAGES in the cran.rb script

What the cran.rb script does:
1) Pull the content of the https://cran.r-project.org/src/contrib/PACKAGES
2) Remove/join multiline that begins with space
3) Parse/put all fields into hash
4) Pull each files/packages from https://cran.r-project.org/src/contrib/*.tar.gz
5) Extract the DESCRIPTION information and parse/put them all into hash
6) Save the hash to a file called "cran.marshal"

To read back/display the hash from cran.marshal:
```$ ./readpackages.rb
```

To schedule the run as cronjob, add this line into the crontab:
```0 12 * * * /mypath/cran.rb >/mypath/cran.log 2>&1
```

