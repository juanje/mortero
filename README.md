Description
===========

This is a simple environment to create and test Chef's LWRPs.

I have to document a bit this...

But to have a first taste let's see some simple steps:

    bundle install
    vagrant up
    git clone git://github.com/gecos-team/cookbook-conf.git cookbooks/conf
    cucumber features/test.feature

You can copy your LWRP's cookbook you like to test into the `cookbooks/`
directory and reuse one of the `features/*.feature` files to test it.

You have some new *step_definitions* to work with *Vagrant* and the *Chef*'s
recipes under the `features/step_definitions` directory, but you can also
use the *Aruba* ones or create your owns.


License and Author
==================

Authors: Juanje Ojeda <juanje.ojeda@gmail.com>

Copyright 2012 Juanje Ojeda <juanje.ojeda@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

