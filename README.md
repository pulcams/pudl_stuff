pudl stuff
==========

Misc. scripts to assist us in loading files into the [pudl](http://pudl.princeton.edu/) (Princeton Univeristy Digital Library).

####reminders
* .xqu = XQuery Update. In oXygen, need to disable XQuery 3.0 support to run these (as of 5/15). Be sure to have backups enabled in before running XQuery Updates (Tools > Options > XML > XSLT-FO-XQuery > XQuery > Saxon-HE/PE/EE > "Backup files updated by XQuery...").
* Collection files ([Saxon collection catalogs](http://saxonica.com/documentation9.5/sourcedocs/collections.html)) can be used to recurse through entire projects. See make-collection.xq.
* On Windows machines, refer to filepaths in oXygen using `file:///`, e.g. `file:///Users/me/svn/pudl0123`
* There are more misc. scripts in svn/puldi/utils
