# Class: fhs_app
# ===========================
#
# Initializes the module, loading the necessary dependencies and classes.
#
# Parameters
# ----------
#
# The following parameters are used:
#
# * `mother`
# A hash that defines the parameters for the mother class.
# These will be used to create the /app FHS hierarchy.
# User, group, permissions and locations are customizable.
# If no mother params are provided, the defaults will be used.
#
# * `childs`
# A hash that defines the parameters for the child class.
# These will be used to create the application user, group and directories.
# User, group, permissions and locations are customizable.
# If no child params are provided, no changes will be made.
# Multiple childs can be provided.
#
# More information can be found on HOWTO.md.
#
# Variables
# ----------
#
# There are no variables being used.
#
# Examples
# --------
#
# @example
#    class { 'fhs_app':
#      mother => {(...)},
#      childs => {(...)},
#    }
#
# More information can be found on HOWTO.md.
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
class fhs_app (

  # Hashes
  $mother                    = $fhs_app::params::mother,
  $childs                    = $fhs_app::params::childs,

) inherits fhs_app::params {

  # Include dependencies
  include stdlib

  # Autoload module classes
  anchor { 'fhs_app::begin': } ->
    # Load Mother class
    class { '::fhs_app::mother': } ->
    # Load Child class
    class { '::fhs_app::child': } ->
  anchor { 'fhs_app::end': }

}
