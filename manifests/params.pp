# Class: fhs_app::params
# ===========================
#
# Stores the default parameters.
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
class fhs_app::params {

  # Defaults hash
  $defaults = {
    mother => {
      user => {
        name     => 'root',
      },
      group => {
        name     => 'root',
      },
      home => {
        path     => '/app',
        mode     => 'u+rwX,g+rX,o+rX',
      },
    },
    childs => {
      user => {
        groups   => 'users',
        shell    => '/bin/false',
        purgeSSH => true,
      },
      group => {
      },
      home => {
        mode     => 'u+rwX,g+rwX,o=',
      },
      dirs => {
        src => {
          path   => 'src',
          mode   => 'u+rwX,g+rwX,o=',
        },
        log => {
          path   => 'log',
          mode   => 'u+rwX,g+rwX,o=',
        },
        data => {
          path   => 'data',
          mode   => 'u+rwX,g+rwX,o=',
        },
        backup => {
          path   => 'backup',
          mode   => 'u+rwX,g+rwX,o=',
        },
      },
    },
  }

}

