# Class: fhs_app::mother
# ===========================
#
# Creates the /app FHS hierarchy, using the mother params provided to init.pp
# or otherwise the defaults stored in params.pp.
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
class fhs_app::mother (

  # Store hashes to simplify variable usage
  $defaults_hsh = $fhs_app::defaults,
  $mother_hsh   = $fhs_app::mother,

) inherits fhs_app {

  # Validate defaults and mother hash
  if is_hash($defaults_hsh) and is_hash($mother_hsh) {

    # Store hashes to simplify variable usage
    $def_mother_hsh = $defaults_hsh[mother]

    #
    # Validate if mother is enabled
    #
    if has_key($mother_hsh, 'manage') {
      if $mother_hsh[manage]==true {

        # Validate shared parameters
        if !has_key($mother_hsh, 'user') and !has_key($def_mother_hsh, 'user') {
          fail('Invalid fhs_app::mother:user and fhs_app::defaults:mother:user hash')
        }
        if !has_key($mother_hsh[user], 'name') and !has_key($def_mother_hsh[user], 'name') {
          fail('Invalid fhs_app::mother:user:name and fhs_app::defaults:mother:user:name hash')
        }
        if !has_key($mother_hsh, 'group') and !has_key($def_mother_hsh, 'group') {
          fail('Invalid fhs_app::mother:group and fhs_app::defaults:mother:group hash')
        }
        if !has_key($mother_hsh[group], 'name') and !has_key($def_mother_hsh[group], 'name') {
          fail('Invalid fhs_app::mother:group:name and fhs_app::defaults:mother:group:name hash')
        }
        if !has_key($mother_hsh[home], 'path') and !has_key($def_mother_hsh[home], 'path') {
          fail('Invalid fhs_app::mother:home:path and fhs_app::defaults:mother:home:path hash')
        }

        #
        # Validate if mother home is enabled
        #
        if has_key($mother_hsh, 'home') {
          if has_key($mother_hsh[home], 'manage') {
            if $mother_hsh[home][manage]==true {
              # Validate specific parameters
              if !has_key($mother_hsh[home], 'mode') and !has_key($def_mother_hsh[home], 'mode') {
                fail('Invalid fhs_app::mother:home:mode and fhs_app::defaults:mother:home:mode hash')
              }
              # Create mother home directory
              file { 'fhs_app-mother-home_dir':
                ensure => inline_template("<% if scope.function_has_key([@mother_hsh['home'], 'target']) %>link<% else %>directory<% end %>"),
                target => inline_template("<% if scope.function_has_key([@mother_hsh['home'], 'target']) %>${mother_hsh[home][target]}<% else %>notlink<% end %>"),
                path   => inline_template("<% if scope.function_has_key([@mother_hsh['home'], 'path']) %>${mother_hsh[home][path]}<% else %>${def_mother_hsh[home][path]}<% end %>"),
                backup => false,
                force  => false,
                purge  => false,
                owner  => inline_template("<% if scope.function_has_key([@mother_hsh['user'], 'name']) %>${mother_hsh[user][name]}<% else %>${def_mother_hsh[user][name]}<% end %>"),
                group  => inline_template("<% if scope.function_has_key([@mother_hsh['group'], 'name']) %>${mother_hsh[group][name]}<% else %>${def_mother_hsh[group][name]}<% end %>"),
                mode   => inline_template("<% if scope.function_has_key([@mother_hsh['home'], 'mode']) %>${mother_hsh[home][mode]}<% else %>${def_mother_hsh[home][mode]}<% end %>"),
              }
            }
          }
        }

      }
    }

  } else {
    fail('Invalid fhs_app::mother and/or fhs_app::defaults hash')
  }

}

