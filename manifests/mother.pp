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
  $defaults = $fhs_app::defaults,
  $mother = $fhs_app::mother,

) inherits fhs_app {

  # Validate defaults and mother hash
  if is_hash($defaults) and is_hash($mother) {

    #
    # Validate if mother is enabled
    #
    if has_key($mother, 'manage') {
      if $mother[manage]==true {

        # Validate shared parameters
        if !has_key($mother, 'user') and !has_key($defaults[mother], 'user') {
          fail('Invalid fhs_app::mother:user and fhs_app::defaults:mother:user hash')
        }
        if !has_key($mother[user], 'name') and !has_key($defaults[mother][user], 'name') {
          fail('Invalid fhs_app::mother:user:name and fhs_app::defaults:mother:user:name hash')
        }
        if !has_key($mother, 'group') and !has_key($defaults[mother], 'group') {
          fail('Invalid fhs_app::mother:group and fhs_app::defaults:mother:group hash')
        }
        if !has_key($mother[group], 'name') and !has_key($defaults[mother][group], 'name') {
          fail('Invalid fhs_app::mother:group:name and fhs_app::defaults:mother:group:name hash')
        }

        #
        # Validate if mother home is enabled
        #
        if has_key($mother, 'home') {
          if has_key($mother[home], 'manage') {
            if $mother[home][manage]==true {
              # Validate specific parameters
              if !has_key($mother[home], 'path') and !has_key($defaults[mother][home], 'path') {
                fail('Invalid fhs_app::mother:home:path and fhs_app::defaults:mother:home:path hash')
              }
              if !has_key($mother[home], 'mode') and !has_key($defaults[mother][home], 'mode') {
                fail('Invalid fhs_app::mother:home:mode and fhs_app::defaults:mother:home:mode hash')
              }
              # Create mother home directory
              file { 'fhs_app-mother-home_dir':
                ensure => inline_template("<% if scope.function_has_key([@mother['home'], 'target']) %>link<% else %>directory<% end %>"),
                target => inline_template("<% if scope.function_has_key([@mother['home'], 'target']) %>${mother[home][target]}<% else %>notlink<% end %>"),
                path   => inline_template("<% if scope.function_has_key([@mother['home'], 'path']) %>${mother[home][path]}<% else %>${defaults[mother][home][path]}<% end %>"),
                backup => false,
                force  => false,
                purge  => false,
                owner  => inline_template("<% if scope.function_has_key([@mother['user'], 'name']) %>${mother[user][name]}<% else %>${defaults[mother][user][name]}<% end %>"),
                group  => inline_template("<% if scope.function_has_key([@mother['group'], 'name']) %>${mother[group][name]}<% else %>${defaults[mother][group][name]}<% end %>"),
                mode   => inline_template("<% if scope.function_has_key([@mother['home'], 'mode']) %>${mother[home][mode]}<% else %>${defaults[mother][home][mode]}<% end %>"),
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

