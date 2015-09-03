The module can be configured with either declarations in a manifest or parameters in hiera.
The defaults hash can be safely ignored.

### Manifest example

```puppet
#
# App
#
class { '::fhs_app':
  defaults = {
    mother => {
      user => {
        name           => 'root',                 # optional, string
      },
      group => {
        name           => 'root',                 # optional, string
      },
      home => {
        path           => '/app',                 # optional, string
        mode           => 'u+rwX,g+rX,o+rX',      # optional, string
      },
    },
    childs => {
      user => {
        groups         => 'users',               # optional, array of strings
        shell          => '/bin/false',          # optional, string
        purgeSSH       => true,                  # optional, boolean
      },
      group => {
      },
      home => {
        mode           => 'u+rwX,g+rwX,o=',      # optional, string
      },
      dirs => {
        src => {
          path         => 'src',                 # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
        log => {
          path         => 'log',                 # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
        data => {
          path         => 'data',                # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
        backup => {
          path         => 'backup',              # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
      },
    },
  }
  mother => {
    manage             => true,                  # optional, boolean
    user => {
      name             => 'root',                # optional, string
    },
    group => {
      name             => 'root',                # optional, string
    },
    home => {
      manage           => true,                  # optional, boolean
      path             => '/app' ,               # optional, string
      target           => '/path',               # optional, string
      mode             => 'u+rwX,g+rX,o+rX',     # optional, string
    },
  },
  childs => {
    user1 => {
      manage           => true,                  # required, boolean
      user => {
        manage         => true,                  # required, boolean
        name           => 'user1',               # optional, string
        uid            => 501,                   # required, number
        groups         => 'users',               # optional, array of strings
        desc           => 'example user',        # optional, string
        shell          => '/bin/false',          # optional, string
        purgeSSH       => true,                  # optional, boolean
      },
      group => {
        manage         => true,                  # required, boolean
        name           => 'group1',              # optional, string
        gid            => 501,                   # required, number
      },
      home => {
        manage         => true,                  # required, boolean
        path           => 'user1',               # optional, string
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rwX,o=',      # optional, string
      },
      dirs => {
        src => {
          manage       => true,                  # required, boolean
          path         => 'src',                 # optional, string
          target       => '/path',               # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
        log => {
          manage       => true,                  # required, boolean
          path         => 'log',                 # optional, string
          target       => '/path',               # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
        data => {
          manage       => true,                  # required, boolean
          path         => 'data',                # optional, string
          target       => '/path',               # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
        backup => {
          manage       => true,                  # required, boolean
          path         => 'backup',              # optional, string
          target       => '/path',               # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
      },
    },
    user2 => {
      manage           => true,                  # required, boolean
      user => {
        manage         => true,                  # required, boolean
        name           => 'user2',               # optional, string
        uid            => 502,                   # required, number
        groups         => 'users',               # optional, array of strings
        desc           => 'example user',        # optional, string
        shell          => '/bin/false',          # optional, string
        purgeSSH       => true,                  # optional, boolean
      },
      group => {
        manage         => true,                  # required, boolean
        name           => 'group2',              # optional, string
        gid            => 502,                   # required, number
      },
      home => {
        manage         => true,                  # required, boolean
        path           => 'user2',               # optional, string
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rwX,o=',      # optional, string
      },
      dirs => {
        src => {
          manage       => true,                  # required, boolean
          path         => 'src',                 # optional, string
          target       => '/path',               # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
        log => {
          manage       => true,                  # required, boolean
          path         => 'log',                 # optional, string
          target       => '/path',               # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
        data => {
          manage       => true,                  # required, boolean
          path         => 'data',                # optional, string
          target       => '/path',               # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
        backup => {
          manage       => true,                  # required, boolean
          path         => 'backup',              # optional, string
          target       => '/path',               # optional, string
          mode         => 'u+rwX,g+rwX,o=',      # optional, string
        },
      },
    },
  },
}

```


### Hiera example

```yaml
---
#
# App
#
fhs_app::defaults:
  mother:
    user:
      name:            root                       # optional, string
    group:
      name:            root                       # optional, string
    home:
      path:            /app                       # optional, string
      mode:            u+rwX,g+rX,o+rX            # optional, string
  childs:
    user:
      groups:          users                     # optional, array of strings
      shell:           /bin/false                # optional, string
      purgeSSH:        true                      # optional, boolean
    group:
    home:
      mode:            u+rwX,g+rwX,o=            # optional, string
    dirs:
      src:
        path:          src                       # optional, string
        mode:          u+rwX,g+rwX,o=            # optional, string
      log:
        path:          log                       # optional, string
        mode:          u+rwX,g+rwX,o=            # optional, string
      data:
        path:          data                      # optional, string
        mode:          u+rwX,g+rwX,o=            # optional, string
      backup:
        path:          backup                    # optional, string
        mode:          u+rwX,g+rwX,o=            # optional, string
fhs_app::mother:
  manage:              true                      # optional, boolean
  user:
    name:              root                      # optional, string
  group:
    name:              root                      # optional, string
  home:
    manage:            true                      # optional, boolean
    path:              /app                      # optional, string
    target:            /path                     # optional, string
    mode:              u+rwX,g+rX,o+rX           # optional, string
fhs_app::childs:
  user1:
    manage:            true                      # required, string
    user:
      manage:          true                      # required, boolean
      name:            user1                     # optional, string
      uid:             501                       # required, number
      groups:          users                     # optional, array of strings
      desc:            example user              # optional, string
      shell:           /bin/false                # optional, string
      purgeSSH:        true                      # optional, boolean
    group:
      manage:          true                      # required, boolean
      name:            group1                    # optional, string
      gid:             501                       # required, number
    home:
      manage:          true                      # required, boolean
      path:            user1                     # optional, string
      target:          /path                     # optional, string
      mode:            u+rwX,g+rwX,o=            # optional, string
    dirs:
      src:
        manage:          true                    # required, boolean
        path:            src                     # optional, string
        target:          /path                   # optional, string
        mode:            u+rwX,g+rwX,o=          # optional, string
      log:
        manage:          true                    # required, boolean
        path:            log                     # optional, string
        target:          /path                   # optional, string
        mode:            u+rwX,g+rwX,o=          # optional, string
      data:
        manage:          true                    # required, boolean
        path:            data                    # optional, string
        target:          /path                   # optional, string
        mode:            u+rwX,g+rwX,o=          # optional, string
      backup:
        manage:          true                    # required, boolean
        path:            backup                  # optional, string
        target:          /path                   # optional, string
        mode:            u+rwX,g+rwX,o=          # optional, string
  user2:
    manage:            true                      # required, string
    user:
      manage:          true                      # required, boolean
      name:            user2                     # optional, string
      uid:             502                       # required, number
      groups:          users                     # optional, array of strings
      desc:            example user              # optional, string
      shell:           /bin/false                # optional, string
      purgeSSH:        true                      # optional, boolean
    group:
      manage:          true                      # required, boolean
      name:            group2                    # optional, string
      gid:             502                       # required, number
    home:
      manage:          true                      # required, boolean
      path:            user2                     # optional, string
      target:          /path                     # optional, string
      mode:            u+rwX,g+rwX,o=            # optional, string
    dirs:
      src:
        manage:          true                    # required, boolean
        path:            src                     # optional, string
        target:          /path                   # optional, string
        mode:            u+rwX,g+rwX,o=          # optional, string
      log:
        manage:          true                    # required, boolean
        path:            log                     # optional, string
        target:          /path                   # optional, string
        mode:            u+rwX,g+rwX,o=          # optional, string
      data:
        manage:          true                    # required, boolean
        path:            data                    # optional, string
        target:          /path                   # optional, string
        mode:            u+rwX,g+rwX,o=          # optional, string
      backup:
        manage:          true                    # required, boolean
        path:            backup                  # optional, string
        target:          /path                   # optional, string
        mode:            u+rwX,g+rwX,o=          # optional, string

```
Additionally, for hiera, the classes lookup must be initialized in the main manifest:
```
hiera_include('classes') 
```

