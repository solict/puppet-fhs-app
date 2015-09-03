# Class: fhs_app::childs
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
class fhs_app::childs (

  # Store hashes to simplify variable usage
  $defaults_hsh = $fhs_app::defaults,
  $mother_hsh   = $fhs_app::mother,
  $childs_hsh   = $fhs_app::childs,

) inherits fhs_app {

  #
  # Validate and iterate through childs hash
  #
  if is_hash($childs_hsh) {
    keys($childs_hsh).each |String $child_str| {

      # Store hashes to simplify variable usage
      $def_mother_hsh = $defaults_hsh[mother]
      $def_childs_hsh = $defaults_hsh[childs]
      $child_hsh      = $childs_hsh[$child_str]

      #
      # Validate if child is enabled
      #
      if has_key($child_hsh, 'manage') {
        if $child_hsh[manage]==true {

          # Validate shared parameters
          if !has_key($mother_hsh[home], 'path') and !has_key($def_mother_hsh[home], 'path') {
            fail('Invalid fhs_app::mother:home:path and fhs_app::defaults:mother:home:path hash')
          } elsif has_key($mother_hsh[home], 'path') {
            $mother_home_path = $mother_hsh[home][path]
          } elsif !has_key($mother_hsh[home], 'path') and has_key($def_mother_hsh[home], 'path') {
            $mother_home_path = $def_mother_hsh[home][path]
          }
          if !has_key($child_hsh[home], 'path') and !has_key($def_childs_hsh[home], 'path') {
            $child_home_path = $child_str
          } elsif has_key($child_hsh[home], 'path') {
            $child_home_path = $child_hsh[home][path]
          } elsif !has_key($child_hsh[home], 'path') and has_key($def_childs_hsh[home], 'path') {
            $child_home_path = $def_childs_hsh[home][path]
          }

          #
          # Validate if child group is enabled
          #
          if has_key($child_hsh, 'group') {
            if has_key($child_hsh[group], 'manage') {
              if $child_hsh[group][manage]==true {
                # Validate specific parameters
                if !has_key($child_hsh[group], 'gid') {
                  fail("Invalid fhs_app::childs:${child_str}:group:gid hash")
                }
                # Create child group in system
                group { "fhs_app-child-${child_str}_group":
                  ensure     => 'present',
                  name       => inline_template("<% if scope.function_has_key([@child_hsh['group'], 'name']) %>${child_hsh[group][name]}<% else %>${child_str}<% end %>"),
                  allowdupe  => false,
                  forcelocal => false,
                  system     => false,
                  gid        => $child_hsh[group][gid],
                }
              }
            }
          }

          #
          # Validate if child user is enabled
          #
          if has_key($child_hsh, 'user') {
            if has_key($child_hsh[user], 'manage') {
              if $child_hsh[user][manage]==true {
                # Validate specific parameters
                if !has_key($child_hsh[group], 'gid') {
                  fail("Invalid fhs_app::childs:${child_str}:group:gid hash")
                }
                if !has_key($child_hsh[user], 'uid') {
                  fail("Invalid fhs_app::childs:${child_str}:user:uid hash")
                }
                # Validate specific parameters
                if !has_key($child_hsh[user], 'groups') and !has_key($def_childs_hsh[user], 'groups') {
                  fail("Invalid fhs_app::childs:${child_str}:user:groups and fhs_app::defaults:childs:user:groups hash")
                }
                # Validate specific parameters
                if !has_key($child_hsh[user], 'shell') and !has_key($def_childs_hsh[user], 'shell') {
                  fail("Invalid fhs_app::childs:${child_str}:user:shell and fhs_app::defaults:childs:user:shell hash")
                }
                # Validate specific parameters
                if !has_key($child_hsh[user], 'purgeSSH') and !has_key($def_childs_hsh[user], 'purgeSSH') {
                  fail("Invalid fhs_app::childs:${child_str}:user:purgeSSH and fhs_app::defaults:childs:user:purgeSSH hash")
                }
                # Create child user in system
                user { "fhs_app-child-${child_str}_user":
                  ensure         => 'present',
                  name           => inline_template("<% if scope.function_has_key([@child_hsh['user'], 'name']) %>${child_hsh[user][name]}<% else %>${child_str}<% end %>"),
                  allowdupe      => false,
                  forcelocal     => false,
                  system         => false,
                  gid            => $child_hsh[group][gid],
                  uid            => $child_hsh[user][uid],
                  membership     => 'minimum',
                  groups         => inline_template("<% if scope.function_has_key([@child_hsh['user'], 'groups']) %>${child_hsh[user][groups]}<% else %>${def_childs_hsh[user][groups]}<% end %>"),
                  comment        => inline_template("<% if scope.function_has_key([@child_hsh['user'], 'desc']) %>${child_hsh[user][desc]}<% end %>"),
                  managehome     => false,
                  home           => "${mother_home_path}/${child_home_path}",
                  shell          => inline_template("<% if scope.function_has_key([@child_hsh['user'], 'shell']) %>${child_hsh[user][shell]}<% else %>${def_childs_hsh[user][shell]}<% end %>"),
                  expiry         => 'absent',
                  purge_ssh_keys => inline_template("<% if scope.function_has_key([@child_hsh['user'], 'purgeSSH']) %>${child_hsh[user][purgeSSH]}<% else %>${def_childs_hsh[user][purgeSSH]}<% end %>"),
                }
              }
            }
          }

          #
          # Validate if child home is enabled
          #
          if has_key($child_hsh, 'home') {
            if has_key($child_hsh[home], 'manage') {
              if $child_hsh[home][manage]==true {
                # Validate specific parameters
                if !has_key($child_hsh[home], 'mode') and !has_key($def_childs_hsh[home], 'mode') {
                  fail("Invalid fhs_app::childs:${child_str}:home:mode and fhs_app::defaults:childs:home:mode hash")
                }
                # Create child home directory
                file { "fhs_app-child-${child_str}_home_dir":
                  ensure => inline_template("<% if scope.function_has_key([@child_hsh['home'], 'target']) %>link<% else %>directory<% end %>"),
                  target => inline_template("<% if scope.function_has_key([@child_hsh['home'], 'target']) %>${child_hsh[home][target]}<% else %>notlink<% end %>"),
                  path   => "${mother_home_path}/${child_home_path}",
                  backup => false,
                  force  => false,
                  purge  => false,
                  owner  => inline_template("<% if scope.function_has_key([@child_hsh['user'], 'name']) %>${child_hsh[user][name]}<% else %>${child_str}<% end %>"),
                  group  => inline_template("<% if scope.function_has_key([@child_hsh['group'], 'name']) %>${child_hsh[group][name]}<% else %>${child_str}<% end %>"),
                  mode   => inline_template("<% if scope.function_has_key([@child_hsh['home'], 'mode']) %>${child_hsh[home][mode]}<% else %>${def_childs_hsh[home][mode]}<% end %>"),
                }

                # Validate and iterate through childs dirs hash
                if has_key($child_hsh, 'dirs') {
                  keys($child_hsh[dirs]).each |String $dir_str| {

                    # Store hashes to simplify variable usage
                    $def_childs_dir_hsh = $def_childs_hsh[dirs][$dir_str]
                    $child_dir_hsh      = $child_hsh[dirs][$dir_str]

                    # Validate shared parameters
                    if !has_key($child_dir_hsh, 'path') and !has_key($def_childs_dir_hsh, 'path') {
                      $child_dir_path = $dir_str
                    } elsif has_key($child_dir_hsh, 'path') {
                      $child_dir_path = $child_dir_hsh[path]
                    } elsif !has_key($child_dir_hsh, 'path') and has_key($def_childs_dir_hsh, 'path') {
                      $child_dir_path = $def_childs_dir_hsh[path]
                    }

                    #
                    # Validate if child dir is enabled
                    #
                    if has_key($child_dir_hsh, 'manage') {
                      if $child_dir_hsh[manage]==true {
                        # Validate specific parameters
                        if !has_key($child_dir_hsh, 'mode') and !has_key($def_childs_dir_hsh, 'mode') {
                          fail("Invalid fhs_app::childs:${child_str}:dirs:${dir_str}:mode and fhs_app::defaults:childs:dirs:${dir_str}:mode hash")
                        }
                        # Create child dir directory
                        file { "fhs_app-child-${child_str}_${dir_str}_dir":
                          ensure => inline_template("<% if scope.function_has_key([@child_dir_hsh, 'target']) %>link<% else %>directory<% end %>"),
                          target => inline_template("<% if scope.function_has_key([@child_dir_hsh, 'target']) %>${child_dir_hsh[target]}<% else %>notlink<% end %>"),
                          path   => "${mother_home_path}/${child_home_path}/${child_dir_path}",
                          backup => false,
                          force  => false,
                          purge  => false,
                          owner  => inline_template("<% if scope.function_has_key([@child_hsh['user'], 'name']) %>${child_hsh[user][name]}<% else %>${child_str}<% end %>"),
                          group  => inline_template("<% if scope.function_has_key([@child_hsh['group'], 'name']) %>${child_hsh[group][name]}<% else %>${child_str}<% end %>"),
                          mode   => inline_template("<% if scope.function_has_key([@child_dir_hsh, 'mode']) %>${child_dir_hsh[mode]}<% else %>${def_childs_dir_hsh[mode]}<% end %>"),
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
    fail("Invalid fhs_app::childs:${child_str} hash")
  }

}

