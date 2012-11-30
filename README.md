CloudEncryptedSync Filesystem Adapter
=====================================

A simple filesystem adapter for the [CloudEncryptedSync](https://github.com/jsgarvin/cloud_encrypted_sync) gem.

This gem is meant primarily to serve as a demo.  Instead of syncing files
to a remote cloud service, this adapter writes the ecrypted files to another
folder on your local filesystem.

In addition to arguments required by [CES](https://github.com/jsgarvin/cloud_encrypted_sync), you must also pass
`--storage-path /some/local/path` which tells [CES](https://github.com/jsgarvin/cloud_encrypted_sync) where to write the encrypted
files to.

In theory, this should work just fine with a NFS mounted folder as well, but
this has not been tested and is not officially supported.
