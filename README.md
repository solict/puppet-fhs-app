# fhs_app

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with the module](#setup)
    * [What the module_affects](#what-the-module-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with the module](#beginning-with-the-module)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Release Notes - Other notable remarks](#release-notes)

## Overview

Puppet module that implements an unofficial extension to Filesystem Hierarchy
Standard (FHS) to manage system applications (users and directory hierarchies).
Designed for Puppet 3.x and newer in POSIX environments.

## Module Description

The module will implement and manage system applications users and directory
hierarchies in scenarios where system administrators wish to bundle, in the
same location, software, logging, data and backups, in contrast to distributing
the files in either the distro or the addon system locations.

It allows to configure and manage the top level location and the respective
locations for all the applications. It also allows configuring and managing
the applications users, groups and directories.

An extension for the Filesystem Hierarchy Standard (FHS) has been prepared for
it. Follows a brief comparison with the standard:

````
|-----------------------------------------------------|
|  App            |  Addon          |  System         |
|-----------------|-----------------|-----------------|
|  root           |  root           |  root           |
|  |              |  |              |  |              |
|  +-etc          |  +-etc          |  +-etc          |
|  | |            |  | |            |  | |            |
|  | +-<app>      |  | +-opt        |  | +-<app>      |
|  |              |  |   |          |  |              |
|  +-app          |  |   +-<app>    |  +-usr          |
|    |            |  |              |  | |            |
|    +-<app>      |  +-opt          |  | +-bin        |
|      |          |  | |            |  | |            |
|      +-src      |  | +-<app>      |  | +-lib        |
|      |          |  |              |  |   |          |
|      +-log      |  +-var          |  |   +-<app>    |
|      |          |    |            |  |              |
|      +-data     |    +-opt        |  +-var          |
|      |          |      |          |  | |            |
|      +-backup   |      +-<app>    |  | +-backup     |
|                 |                 |  | | |          |
|                 |                 |  | | +-<app>    |
|                 |                 |  | |            |
|                 |                 |  | +-lib        |
|                 |                 |  | | |          |
|                 |                 |  | | +-<app>    |
|                 |                 |  | |            |
|                 |                 |  | +-log        |
|                 |                 |  |   |          |
|                 |                 |  |   +-<app>    |
|                 |                 |  |              |
|                 |                 |  +-srv          |
|                 |                 |    |            |
|                 |                 |    +-<app>      |
|                 |                 |                 |
|-----------------------------------------------------|
````

Via this implementation it is thus possible to satisfy scenarios where it is
more important to keep most files of an application together, which can be the
case for Docker containers, custom builds of known packages, custom software,
big infrastructures with many complex scenarios, etc., relying on simplicity.

Care should be given to deploy the app hierarchy in a separate mount point.

This module has been desgined for Puppet 3.x and newer in POSIX environments.

## Setup

### What the module affects

* Directory hierarchies will be created for the app location and also for all
applications parameterized, permissions and owners included.
* System users and groups will be generated for applications, where applicable.

### Setup Requirements

The following modules are requirements and should be installed.
* puppetlabs-stdlib

### Beginning with the module

When deployed, the directory of the module should be renamed to fhs_app.

The class fhs_app must be declared in a manifest or loaded with
hiera_include to be initialized.
All other classes are autoloaded and do not need to be manually initialized.

Parameters can be provided with both methods, for the class fhs_app.

## Usage

The following parameters are used:

* `defaults`
A hash that defines the default parameters.
It is hard coded into params.pp and can be ignored.
They are used when the other hashes are missing or incomplete.

* `mother`
A hash that defines the parameters for the mother class.
These will be used to create the /app FHS hierarchy.
User, group, permissions and locations are customizable.
If no mother params are provided, the defaults will be used.

* `childs`
A hash that defines the parameters for the child class.
These will be used to create the application user, group and directories.
User, group, permissions and locations are customizable.
If no child params are provided, no changes will be made.
Multiple childs can be provided.

The file HOWTO.md details sample usage with manifests and hiera.

## Reference

There are 4 classes provided by this module:
- fhs_app, which initializes the module are accepts parameters
- fhs_app::params, which is autoloaded to retrieve parameters
- fhs_app::mother, which is autoloaded to create the /app FHS hierarchy
- fhs_app::childs, which is autoloaded to create the provided applications

The parameterized user, group and file resources are managed as configured, as
defined for params mother and childs.

No new resources are provided.

## Limitations

It has been successfully tested in CentOS/RHEL and Debian.
Should be compatible with most of the Linux distributions.

## Development

The source for the module can be found on it's project source page.
Contributions and issues are welcomed.

## Release Notes

This source code comes with absolutely no warranty or liability for damages.

