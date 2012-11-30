CloudEncryptedSync Filesystem Adapter
=====================================

A simple filesystem adapter for the [CloudEncryptedSync](https://github.com/jsgarvin/cloud_encrypted_sync) gem.

This gem is meant primarily to serve as a demo.  Instead of syncing files
to a remote cloud service, this adapter writes the ecrypted files to another
folder on your local filesystem.

In addition to arguments required by [CES](https://github.com/jsgarvin/cloud_encrypted_sync), you must also pass
`--storage-path /some/local/path` which tells [CES](https://github.com/jsgarvin/cloud_encrypted_sync) where to write the encrypted
files to.

This adapter has been briefly tested with [Ubuntu One](https://one.ubuntu.com/referrals/referee/2304745/)
and [Dropbox](http://db.tt/X7KUvsGn "Dropbox") folders and seems to work quite well.
Other cloud storage services that use a "magic" folder on your local filesystem will
probably work just as well.  Note that you probably don't want to use the root folder
in the cloud storage service (i.e. ~/Dropbox) but should instead use a subfolder
(i.e. ~/Dropobox/world_domination_plans)

In theory, this adapter should also work with NFS mounted folders, but
this has not been tested and is not officially supported.
