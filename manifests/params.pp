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

  # Mother hash
  $mother = {
    self => {
      manage     => true,
      user => {
        name     => 'root',
      },
      group => {
        name     => 'root',
      },
      root => {
        manage   => true,
        path     => "/app",
        mode     => 'u+rwX,g+rX,o+rX',
      },
      homes => {
        manage   => true,
        path     => "/app/users",
        mode     => 'u+rwX,g+rX,o+rX',
      },
      logs => {
        manage   => true,
        path     => "/app/logs",
        mode     => 'u+rwX,g+rX,o+rX',
      },
      backups => {
        manage   => true,
        path     => "/app/backups",
        mode     => 'u+rwX,g+rX,o+rX',
      },
    },
    defaults => {
      home => {
        mode     => 'u+rwX,g+rwX,o=',
      },
      log => {
        mode     => 'u+rwX,g+rwX,o=',
      },
      backup => {
        mode     => 'u+rwX,g+rwX,o=',
      },
    },
  }

  # Childs hash
  $childs = {
  }

}

