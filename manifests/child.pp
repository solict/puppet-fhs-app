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
  $defaults = $fhs_app::defaults,
  $mother = $fhs_app::mother,
  $childs = $fhs_app::childs,

) inherits fhs_app {

  #
  # Validate and iterate through childs hash
  #
  if is_hash($childs) {
    keys($childs).each |String $child| {

      #
      # Validate if child is enabled
      #
      if has_key($childs[$child], 'manage') {
        if $childs[$child][manage]==true {

          #
          # Validate if child group is enabled
          #
          if has_key($childs[$child], 'group') {
            if has_key($childs[$child][group], 'manage') {
              if $childs[$child][group][manage]==true {
                # Validate specific parameters
                if !has_key($childs[$child][group], 'gid') {
                  fail("Invalid fhs_app::childs:${child}:group:gid hash")
                }
                # Create child group in system
                group { "fhs_app-child-${child}_group":
                  ensure     => 'present',
                  name       => inline_template("<% if scope.function_has_key([@childs[@child]['group'], 'name']) %>${childs[$child][group][name]}<% else %>${child}<% end %>"),
                  allowdupe  => false,
                  forcelocal => false,
                  system     => false,
                  gid        => $childs[$child][group][gid],
                }
              }
            }
          }

          #
          # Validate if child user is enabled
          #
          if has_key($childs[$child], 'user') {
            if has_key($childs[$child][user], 'manage') {
              if $childs[$child][user][manage]==true {
                # Validate specific parameters
                if !has_key($childs[$child][group], 'gid') {
                  fail("Invalid fhs_app::childs:${child}:group:gid hash")
                }
                if !has_key($childs[$child][user], 'uid') {
                  fail("Invalid fhs_app::childs:${child}:user:uid hash")
                }
                # Create child user in system
                user { "fhs_app-child-${child}_user":
                  ensure         => 'present',
                  name           => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'name']) %>${childs[$child][user][name]}<% else %>${child}<% end %>"),
                  allowdupe      => false,
                  forcelocal     => false,
                  system         => false,
                  gid            => $childs[$child][group][gid],
                  uid            => $childs[$child][user][uid],
                  membership     => 'minimum',
                  groups         => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'groups']) %>${childs[$child][user][groups]}<% else %>${defaults[childs][user][groups]}<% end %>"),
                  comment        => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'desc']) %>${childs[$child][user][desc]}<% end %>"),
                  managehome     => false,
                  home           => "${mother[home][path]}/${child}",
                  shell          => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'shell']) %>${childs[$child][user][shell]}<% else %>${defaults[childs][user][shell]}<% end %>"),
                  expiry         => 'absent',
                  purge_ssh_keys => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'purgeSSH']) %>${childs[$child][user][purgeSSH]}<% else %>${defaults[childs][user][purgeSSH]}<% end %>"),
                }
              }
            }
          }

          #
          # Validate if child home is enabled
          #
          if has_key($childs[$child], 'home') {
            if has_key($childs[$child][home], 'manage') {
              if $childs[$child][home][manage]==true {
                # Validate specific parameters
                if !has_key($childs[$child][home], 'mode') and !has_key($defaults[childs][home], 'mode') {
                  fail("Invalid fhs_app::childs:${child}:home:mode and fhs_app::defaults:childs:home:mode hash")
                }
                # Create child home directory
                file { "fhs_app-child-${child}_home_dir":
                  ensure => inline_template("<% if scope.function_has_key([@childs[@child]['home'], 'target']) %>link<% else %>directory<% end %>"),
                  target => inline_template("<% if scope.function_has_key([@childs[@child]['home'], 'target']) %>${childs[$child][home][target]}<% else %>notlink<% end %>"),
                  path   => "${mother[home][path]}/${child}",
                  backup => false,
                  force  => false,
                  purge  => false,
                  owner  => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'name']) %>${childs[$child][user][name]}<% else %>${child}<% end %>"),
                  group  => inline_template("<% if scope.function_has_key([@childs[@child]['group'], 'name']) %>${childs[$child][group][name]}<% else %>${child}<% end %>"),
                  mode   => inline_template("<% if scope.function_has_key([@childs[@child]['home'], 'mode']) %>${childs[$child][home][mode]}<% else %>${defaults[childs][home][mode]}<% end %>"),
                }

                # Validate and iterate through childs dirs hash
                if has_key($childs[$child], 'dirs') {
                  keys($childs[$child][dirs]).each |String $dir| {

                    #
                    # Validate if child dir is enabled
                    #
                    if has_key($childs[$child][dirs][$dir], 'manage') {
                      if $childs[$child][dirs][$dir][manage]==true {
                        # Validate specific parameters
                        if !has_key($childs[$child][dirs][$dir], 'path') and !has_key($defaults[childs][dirs][$dir], 'path') {
                          fail("Invalid fhs_app::childs:${child}:dirs:${dir}:path and fhs_app::defaults:childs:dirs:${dir}:path hash")
                        }
                        if !has_key($childs[$child][dirs][$dir], 'mode') and !has_key($defaults[childs][dirs][$dir], 'mode') {
                          fail("Invalid fhs_app::childs:${child}:dirs:${dir}:mode and fhs_app::defaults:childs:dirs:${dir}:mode hash")
                        }
                        # Create child dir directory
                        file { "fhs_app-child-${child}_${dir}_dir":
                          ensure => inline_template("<% if scope.function_has_key([@childs[@child]['dirs'][@dir], 'target']) %>link<% else %>directory<% end %>"),
                          path   => inline_template("<% if scope.function_has_key([@childs[@child]['dirs'][@dir], 'path']) %>${mother[home][path]}/${child}/${childs[$child][dirs][$dir][path]}<% else %>${mother[home][path]}/${child}/${defaults[childs][dirs][$dir][path]}<% end %>"),
                          target => inline_template("<% if scope.function_has_key([@childs[@child]['dirs'][@dir], 'target']) %>${childs[$child][dirs][$dir][target]}<% else %>notlink<% end %>"),
                          backup => false,
                          force  => false,
                          purge  => false,
                          owner  => inline_template("<% if scope.function_has_key([@childs[@child]['user'], 'name']) %>${childs[$child][user][name]}<% else %>${child}<% end %>"),
                          group  => inline_template("<% if scope.function_has_key([@childs[@child]['group'], 'name']) %>${childs[$child][group][name]}<% else %>${child}<% end %>"),
                          mode   => inline_template("<% if scope.function_has_key([@childs[@child]['dirs'][@dir], 'mode']) %>${childs[$child][dirs][$dir][mode]}<% else %>${defaults[childs][dirs][$dir][mode]}<% end %>"),
                        }
                      }
                    }

                  }
                }

              }
            }
          }

        }
      }

    }
  } else {
    fail("Invalid fhs_app::childs:${child} hash")
  }

}

