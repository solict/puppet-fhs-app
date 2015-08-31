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
  $mother = $fhs_app::mother,

) inherits fhs_app {

  # Validate mother hash
  if has_key($mother, 'self') and has_key($mother, 'defaults') {

    #
    # Validate if mother is enabled
    #
    if has_key($mother[self], 'manage') {
      if $mother[self][manage]==true {

        #
        # Validate the main parameters
        #
        if !has_key($mother[self], 'user') {
          fail('Invalid fhs_app::mother:self:user hash')
        }
        if !has_key($mother[self][user], 'name') {
          fail('Invalid fhs_app::mother:self:user:name hash')
        }
        if !has_key($mother[self], 'group') {
          fail('Invalid fhs_app::mother:self:group hash')
        }
        if !has_key($mother[self][group], 'name') {
          fail('Invalid fhs_app::mother:self:group:name hash')
        }

        #
        # Validate if mother root is enabled
        #
        if has_key($mother[self][root], 'manage') {
          if $mother[self][root][manage]==true {
            #
            # Validate other parameters
            #
            if !has_key($mother[self][root], 'path') {
              fail('Invalid fhs_app::mother:self:root:path hash')
            }
            if !has_key($mother[self][root], 'mode') {
              fail('Invalid fhs_app::mother:self:root:mode hash')
            }
            # Create root directory
            file { 'fhs_app-mother-root_dir':
              ensure => 'directory',
              path   => $mother[self][root][path],
              backup => false,
              force  => false,
              purge  => false,
              owner  => $mother[self][user][name],
              group  => $mother[self][group][name],
              mode   => $mother[self][root][mode],
            }
          }
        }

        #
        # Validate if mother homes is enabled
        #
        if has_key($mother[self][homes], 'manage') {
          if $mother[self][homes][manage]==true {
            #
            # Validate other parameters
            #
            if !has_key($mother[self][homes], 'path') {
              fail('Invalid fhs_app::mother:self:homes:path hash')
            }
            if !has_key($mother[self][homes], 'mode') {
              fail('Invalid fhs_app::mother:self:homes:mode hash')
            }
            # Create homes directory
            file { 'fhs_app-mother-homes_dir':
              ensure => 'directory',
              path   => $mother[self][homes][path],
              backup => false,
              force  => false,
              purge  => false,
              owner  => $mother[self][user][name],
              group  => $mother[self][group][name],
              mode   => $mother[self][homes][mode],
            }
          }
        }

        #
        # Validate if mother logs is enabled
        #
        if has_key($mother[self][logs], 'manage') {
          if $mother[self][logs][manage]==true {
            #
            # Validate other parameters
            #
            if !has_key($mother[self][logs], 'path') {
              fail('Invalid fhs_app::mother:self:logs:path hash')
            }
            if !has_key($mother[self][logs], 'mode') {
              fail('Invalid fhs_app::mother:self:logs:mode hash')
            }
            # Create logs directory
            file { 'fhs_app-mother-logs_dir':
              ensure => 'directory',
              path   => $mother[self][logs][path],
              backup => false,
              force  => false,
              purge  => false,
              owner  => $mother[self][user][name],
              group  => $mother[self][group][name],
              mode   => $mother[self][logs][mode],
            }
          }
        }

        #
        # Validate if mother backups is enabled
        #
        if has_key($mother[self][backups], 'manage') {
          if $mother[self][backups][manage]==true {
            #
            # Validate other parameters
            #
            if !has_key($mother[self][backups], 'path') {
              fail('Invalid fhs_app::mother:self:backups:path hash')
            }
            if !has_key($mother[self][backups], 'mode') {
              fail('Invalid fhs_app::mother:self:backups:mode hash')
            }
            # Create backups directory
            file { 'fhs_app-mother-backups_dir':
              ensure => 'directory',
              path   => $mother[self][backups][path],
              backup => false,
              force  => false,
              purge  => false,
              owner  => $mother[self][user][name],
              group  => $mother[self][group][name],
              mode   => $mother[self][backups][mode],
            }
          }
        }

      }
    }

  }
  else {
    fail('Invalid fhs_app::mother:self and/or fhs_app::mother:defaults hash')
  }

}

