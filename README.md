# vagrant-mediawiki

MediaWiki container demonstration and development.

### Notes about LDAP

- This demonstration includes LDAP integration, which is optional and dependent on the existence of the  `./ldapprovider.json` file. Since this configuration is infrastructure-dependent, it can not be included.
    - [LDAPProvider Documentation](https://www.mediawiki.org/wiki/Extension:LDAPProvider#Domain_config_providers)
- This guide additionally assumes you have solved routing into your LDAP server from a guest environment, presumably by using [sshuttle](https://sshuttle.readthedocs.io/en/stable/) on the host to forward connections to particular IP addresses through an SSH tunnel.

    i.e.
    ```
    sshuttle -v -r me@example.com:22 -x example.com:22 X.X.X.X/XX
    ```

### Quick Start
1. Start Vagrant
    ```
    vagrant up
    ```

2. Navigate to [http://localhost:8080/](http://localhost:8080/) and login
    - If the `./ldapprovider.json` file wasn't included, the login credentials are:
        - user: `Admin`
        - pass: `adminpassword123`
    - If the file was included, **all** logins will authenticate against LDAP
        - Set `$LDAPAuthentication2AllowLocalLogin` to `true` in `./LocalSettings.php` to allow local authentication
        - [LDAPAutentication2 Documentation](https://www.mediawiki.org/wiki/Extension:LDAPAuthentication2#Extension_settings)


#### Copyrights and Licenses
Copyright 2021  Kris Lamoureux

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
