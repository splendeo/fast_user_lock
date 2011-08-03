# Redmine sample plugin
require 'redmine'
require 'dispatcher'

RAILS_DEFAULT_LOGGER.info 'Starting Example plugin for RedMine'

Dispatcher.to_prepare :fast_user_lock do
  require_dependency 'users_helper'
  UsersHelper.send(:include, FastUserLock::Patches::UsersHelperPatch)
end

Redmine::Plugin.register :fast_user_lock do
  name 'Fast Lock User'
  author 'Francisco de Juan'
  description 'Plugin for Redmine/Chiliproject for allowing lock of users without activating first'
  version '0.0.1'
end
