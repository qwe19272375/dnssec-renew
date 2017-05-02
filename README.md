# dnssec-renew
change settings below to meet your need
* `ZONE=yourdomain.com`
* `ZONEFILE="/path/to/zonefile"`
* `KSK="/path/to/KSK"`
* `ZSK="/path/to/ZSK"`

This shell script will sign the zonefile with randomly generated salt and reload bind.

It will not change the serial number nor reload bind if failed.
