# vagrant-mediawiki

MediaWiki container demonstration and development.

### Quick Start
1. Start Vagrant and login to root

   ```
   $ vagrant up
   $ vagrant ssh
   vagrant@bullseye:~$ sudo -i
   root@bullseye:~#
   ```

2. Run the docker-compose file

   ```
   root@bullseye:~# cd /vagrant
   root@bullseye:/vagrant# docker-compose up -d
   ```

3. Navigate to [http://localhost:8080/](http://localhost:8080/) to set up LocalSettings.php

   Database host: `database` <br>
   Database name: `mediawiki` <br>
   Database user: `mediawiki` <br>
   Database pass: `password123`

4. Download LocalSettings.php to the root of the vagrant project

5. Uncomment the LocalSettings bind mount in the compose file:

   ```
   sed -i 's/#- .\/LocalSettings.php/- .\/LocalSettings.php/' docker-compose.yml
   docker-compose up -d
   ```

6. Manually add the following to the bottom of the LocalSettings.php file:

   ```
   wfLoadExtension( 'PluggableAuth' );
   wfLoadExtension( 'LDAPProvider' );
   wfLoadExtension( 'LDAPAuthentication2' );
   wfLoadExtension( 'VisualEditor' );
   ```

7. Run the update PHP script

   ```
   docker exec -it vagrant-mediawiki-1 php maintenance/update.php
   ```

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
