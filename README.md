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
dockerapp_fusio::host_name: apldc1vds0044.fgv.br
dockerapp_fusio::env: develop
dockerapp_fusio::project_key: jhkgsdWw478cgCj62Cjdgz31Z0mvDS74
dockerapp_fusio::db_pw: kslkujsd7xjS865mnf29x
dockerapp_fusio::backend_user: admin
dockerapp_fusio::backend_email: seguranca-info@fgv.br
dockerapp_fusio::backend_pw: kkhXh9gsCg51sxm
dockerapp_fusio::mysql_password: kslkujsd7xjS865mnf29x
dockerapp_fusio::mysql_root_pw: kljs7Xhsgz86237
```


## Development

Please make sure all tests are running on every commit. 

