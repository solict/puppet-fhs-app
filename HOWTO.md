The module can be configured with either declarations in a manifest or parameters in hiera.

### Manifest example

```puppet
#
# App
#
class { '::fhs_app':
  mother => {
    self => {
      manage           => true,                  # optional, boolean
      user => {
        name           => 'root',                # optional, string
      },
      group => {
        name           => 'root',                # optional, string
      },
      root => {
        manage         => true,                  # optional, boolean
        path           => "/app",                # optional, string
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rX,o+rX',     # optional, string
      },
      homes => {
        manage         => true,                  # optional, boolean
        path           => "/app/users",          # optional, string
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rX,o+rX',     # optional, string
      },
      logs => {
        manage         => true,                  # optional, boolean
        path           => "/app/logs",           # optional, string
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rX,o+rX',     # optional, string
      },
      backups => {
        manage         => true,                  # optional, boolean
        path           => "/app/backups",        # optional, string
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rX,o+rX',     # optional, string
      },
    },
    defaults => {
      home => {
        mode     => 'u+rwX,g+rwX,o=',            # optional, string
      },
      log => {
        mode     => 'u+rwX,g+rwX,o=',            # optional, string
      },
      backup => {
        mode     => 'u+rwX,g+rwX,o=',            # optional, string
      },
    },
  },
  childs => {
    user1 => {
      manage           => true,                  # required, boolean
      name             => 'user1',               # required, string
      user => {
        manage         => true,                  # required, boolean
        name           => 'user1',               # optional, string
        uid            => 501,                   # required, number
        groups         => [users],               # optional, array of strings
        desc           => 'example user',        # optional, string
      },
      group => {
        manage         => true,                  # required, boolean
        name           => 'group1',              # optional, string
        gid            => 501,                   # required, number
      },
      home => {
        manage         => true,                  # required, boolean
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rwX,o=',      # optional, string
      },
      log => {
        manage         => true,                  # required, boolean
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rwX,o=',      # optional, string
      },
      backup => {
        manage         => true,                  # required, boolean
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rwX,o=',      # optional, string
      },
    },
    user2 => {
      manage           => true,                  # required, boolean
      name             => 'user2',               # required, string
      user => {
        manage         => true,                  # required, boolean
        name           => 'user2',               # optional, string
        uid            => 502,                   # required, number
        groups         => [users],               # optional, array of strings
        desc           => 'example user',        # optional, string
      },
      group => {
        manage         => true,                  # required, boolean
        name           => 'group2',              # optional, string
        gid            => 502,                   # required, number
      },
      home => {
        manage         => true,                  # required, boolean
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rwX,o=',      # optional, string
      },
      log => {
        manage         => true,                  # required, boolean
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rwX,o=',      # optional, string
      },
      backup => {
        manage         => true,                  # required, boolean
        target         => '/path',               # optional, string
        mode           => 'u+rwX,g+rwX,o=',      # optional, string
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
fhs_app::mother:
  self:
    manage:            true                      # optional, boolean
    user:
      name:            root                      # optional, string
    group:
      name:            root                      # optional, string
    root:
      manage:          true                      # optional, boolean
      path:            /app                      # optional, string
      target:          /path                     # optional, string
      mode:            u+rwX,g+rX,o+rX           # optional, string
    homes:
      manage:          true                      # optional, boolean
      path:            /app/users                # optional, string
      target:          /path                     # optional, string
      mode:            u+rwX,g+rX,o+rX           # optional, string
    logs:
      manage:          true                      # optional, boolean
      path:            /app/logs                 # optional, string
      target:          /path                     # optional, string
      mode:            u+rwX,g+rX,o+rX           # optional, string
    backups:
      manage:          true                      # optional, boolean
      path:            /app/backups              # optional, string
      target:          /path                     # optional, string
      mode:            u+rwX,g+rX,o+rX           # optional, string
  defaults:
    home:
      mode:            u+rwX,g+rwX,o=            # optional, string
    log:
      mode:            u+rwX,g+rwX,o=            # optional, string
    backup:
      mode:            u+rwX,g+rwX,o=            # optional, string

fhs_app::childs:
  list:
    - user1                                      # required, string
    - user2                                      # required, string
  user1:
    manage:            true                      # required, string
    user:
      manage:          true                      # required, boolean
      name:            user1                     # optional, string
      uid:             501                       # required, number
      groups:          users                     # optional, array of strings
      desc:            example user              # optional, string
    group:
      manage:          true                      # required, boolean
      name:            group1                    # optional, string
      gid:             501                       # required, number
    home:
      manage:          true                      # required, boolean
      target:          /path                     # optional, string
      mode:            u+rwX,g+rwX,o=            # optional, string
    log:
      manage:          true                      # required, boolean
      target:          /path                     # optional, string
      mode:            u+rwX,g+rwX,o=            # optional, string
    backup:
      manage:          true                      # required, boolean
      target:          /path                     # optional, string
      mode:            u+rwX,g+rwX,o=            # optional, string
  user2:
    manage:            true                      # required, string
    user:
      manage:          true                      # required, boolean
      name:            user2                     # optional, string
      uid:             502                       # required, number
      groups:          users                     # optional, array of strings
      desc:            example user              # optional, string
    group:
      manage:          true                      # required, boolean
      name:            group2                    # optional, string
      gid:             502                       # required, number
    home:
      manage:          true                      # required, boolean
      target:          /path                     # optional, string
      mode:            u+rwX,g+rwX,o=            # optional, string
    log:
      manage:          true                      # required, boolean
      target:          /path                     # optional, string
      mode:            u+rwX,g+rwX,o=            # optional, string
    backup:
      manage:          true                      # required, boolean
      target:          /path                     # optional, string
      mode:            u+rwX,g+rwX,o=            # optional, string

```
Additionally, for hiera, the classes lookup must be initialized in the main manifest:
```
hiera_include('classes') 
```

