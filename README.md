pudl stuff
==========

Misc. scripts to assist us (CaMS) in loading files into the [pudl](http://pudl.princeton.edu/) (Princeton Univeristy Digital Library).

#### XQuery/XSLT reminders
* .xqu = XQuery Update. In oXygen, need to disable XQuery 3.0 support to run these (as of 5/15). Be sure to have backups enabled in before running XQuery Updates (Tools > Options > XML > XSLT-FO-XQuery > XQuery > Saxon-HE/PE/EE > "Backup files updated by XQuery...").
* Collection files ([Saxon collection catalogs](http://saxonica.com/documentation9.5/sourcedocs/collections.html)) can be used to recurse through entire projects. See make-collection.xq.
* On Windows machines, refer to filepaths in oXygen using `file:///`, e.g. `file:///Users/me/svn/pudl0123`
* There are more misc. scripts in svn/puldi/utils

#### Past Fixes

These are issues that took some time and collaboration to resolve, so recording them here for our collective memory.

* pudl0094 - Obj METS not generating for multi-volume collection due to absence of image headers and then incorrect values in mets:mptr. Needed to replace `8941435/vol01.mets` with `8941435.mets` in URLs. Bash script used:
 ```
 $ for m in `find . -name "*.mets"`; do sed -r -e 's|8941435/vol[0-9]{2}\.mets|8941435.mets|' $m; done
 ```

* pudl0058 - need to confirm number of image METS
```
$ cd pudl0058
$ find . -type f -name "*.mets" | wc -l
```

* pudl0003/c83_3828.mets - Image METS were regenerated after changing dir structure. Values in mets:mptr then needed to be changed from `pudl0003.c83_3828.mets` to `pudl0003/c83_3828.mets` in order to generate new Obj METS.
