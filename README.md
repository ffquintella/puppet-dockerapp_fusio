# dockerapp_tyk

This module installs the fusio api gateway using puppet and docker


## Description

This module installs the tyk api gateway using puppet and docker


### Beginning with dockerapp_fusio

This is the first realease expect bugs.

## Usage

Just call the class and pass the parameters 

in yml this would be:

```yaml
dockerapp_fusio::host_name: xxx.xx.br
dockerapp_fusio::env: develop
dockerapp_fusio::project_key: xxxx
dockerapp_fusio::db_pw: JSDHSD
dockerapp_fusio::backend_user: admin
dockerapp_fusio::backend_email: no@mail.com
dockerapp_fusio::backend_pw: xcxcxc
dockerapp_fusio::mysql_password: xcxcxc
dockerapp_fusio::mysql_root_pw: xcxcxc
```


## Development

Please make sure all tests are running on every commit. 

