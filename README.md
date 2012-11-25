CloudEncryptedSync Baseline Adapter
=====================================

This repository is intended to be to be a starting point for creating
your own adapter gem for CloudEncryptedSync.

Before proceeding, exercise due diligence to make sure somebody hasn't
already created an adapter to the cloud storage service you would like
to use.

* Fork this repository, and change the word "baseline" in the title
  of your fork to the name of the cloud your adapter will interface
  with. (eg, clound_encrypted_sync_s3_adapter )
* Clone your fork.
* Search the entire codebase and change every instance of the word
  "baseline" as appropriate.
* Update necessary fields in the gemspec file.
* Add tests and update methods in lib/adapters/baseline.rb as
  necessary. (Note: If you followed the previous step correctly, then
  you changed the name of the "baseline.rb" file in /lib/adapters to
  something else. Don't let this confuse you.)
