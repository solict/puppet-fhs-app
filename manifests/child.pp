# Class: fhs_app::child
# ===========================
#
# Creates the application user, group and directories, using the child params
# provided to init.pp. If no parameters are provided, no changes are made.
# Multiple childs can be provided.
#
# Authors
# -------
#
# Luís Pedro Algarvio <lp.algarvio@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2015 SOL-ICT.
#
class fhs_app::child (

  # Store hashes to simplify variable usage
  $mother = $fhs_app::mother,
  $childs = $fhs_app::childs,

) inherits fhs_app::params {

  # Iterate through childs
  $childs[list].each |String $child| {
    if has_key($childs, $child) and is_string($child) {

      /**
      * Validate if child is enabled
      */
      if has_key($childs[$child], 'manage') {
        if $childs[$child][manage]==true {

          /**
          * Validate if child group is enabled
          */
          if has_key($childs[$child][group], 'manage') {
            if $childs[$child][group][manage]==true {
              # Create group in system
              group { "fhs_app-child-${child}_group":
                name             => inline_template("<% if scope.function_has_key([@childs[@child]['group'], 'name']) %>${childs[$child][group][name]}<% else %>${child}<% end %>"),
                ensure           => 'present',
                allowdupe        => false,
                forcelocal       => false,
                system           => false,
                gid              => $childs[$child][group][gid],
              }
            }
          }

          /**
          * Validate if child user is enabled
          */
          if has_key($childs[$child][user], 'manage') {
            if $childs[$child][user][manage]==true {
              # Create user in system
              user { "fhs_app-child-${child}_user":
                name             => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'name']) %>${childs[$child][user][name]}<% else %>${child}<% end %>"),
                ensure           => 'present',
                allowdupe        => false,
                forcelocal       => false,
                system           => false,
                gid              => $childs[$child][group][gid],
                uid              => $childs[$child][user][uid],
                membership       => "minimum",
                groups           => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'groups']) %>${childs[$child][user][groups]}<% else %>users<% end %>"),
                comment          => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'desc']) %>${childs[$child][user][desc]}<% end %>"),
                managehome       => false,
                home             => "${mother[self][homes][path]}/${child}",
                shell            => '/bin/false',
                expiry           => 'absent',
                purge_ssh_keys   => true,
              }
            }
          }

          /**
          * Validate if child home is enabled
          */
          if has_key($childs[$child][home], 'manage') {
            if $childs[$child][home][manage]==true {
              # Create home directory
              file { "fhs_app-child-${child}_home_dir":
                path             => "${mother[self][homes][path]}/${child}",
                ensure           => 'directory',
                backup           => false,
                force            => false,
                purge            => false,
                owner            => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'name']) %>${childs[$child][user][name]}<% else %>${child}<% end %>"),
                group            => inline_template("<% if scope.function_has_key([@childs[@child]['group'], 'name']) %>${childs[$child][group][name]}<% else %>${child}<% end %>"),
                mode             => inline_template("<% if scope.function_has_key([@childs[@child]['home'], 'mode']) %>${childs[$child][home][mode]}<% else %>${mother[defaults][home][mode]}<% end %>"),
              }
            }
          }

          /**
          * Validate if child log is enabled
          */
          if has_key($childs[$child][log], 'manage') {
            if $childs[$child][log][manage]==true {
              # Create log directory
              file { "fhs_app-child-${child}_log_dir":
                path             => "${mother[self][logs][path]}/${child}",
                ensure           => 'directory',
                backup           => false,
                force            => false,
                purge            => false,
                owner            => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'name']) %>${childs[$child][user][name]}<% else %>${child}<% end %>"),
                group            => inline_template("<% if scope.function_has_key([@childs[@child]['group'], 'name']) %>${childs[$child][group][name]}<% else %>${child}<% end %>"),
                mode             => inline_template("<% if scope.function_has_key([@childs[@child]['log'], 'mode']) %>${childs[$child][log][mode]}<% else %>${mother[defaults][log][mode]}<% end %>"),
              }
            }
          }

          /**
          * Validate if child backup is enabled
          */
          if has_key($childs[$child][backup], 'manage') {
            if $childs[$child][backup][manage]==true {
              # Create backup directory
              file { "fhs_app-child-${child}_backup_dir":
                path             => "${mother[self][backups][path]}/${child}",
                ensure           => 'directory',
                backup           => false,
                force            => false,
                purge            => false,
                owner            => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'name']) %>${childs[$child][user][name]}<% else %>${child}<% end %>"),
                group            => inline_template("<% if scope.function_has_key([@childs[@child]['group'], 'name']) %>${childs[$child][group][name]}<% else %>${child}<% end %>"),
                mode             => inline_template("<% if scope.function_has_key([@childs[@child]['backup'], 'mode']) %>${childs[$child][backup][mode]}<% else %>${mother[defaults][backup][mode]}<% end %>"),
              }
            }
          }

        }
      }

    }
    else {
      fail("Invalid fhs_app::childs:child hash")
    }
  }

}

