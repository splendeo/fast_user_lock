module FastUserLock
  module UsersHelperPatch
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
        alias_method_chain :change_status_link, :fast_user_lock
      end
    end
    
    module ClassMethods
    end
    
    module InstanceMethods
      def change_status_link_with_fast_user_lock(user)
        url = {:controller => 'users', :action => 'update', :id => user, :page => params[:page], :status => params[:status], :tab => nil}

        if user.locked?
          link_to l(:button_unlock), url.merge(:user => {:status => User::STATUS_ACTIVE}), :method => :put, :class => 'icon icon-unlock'
        elsif user.registered?
          link_to(l(:button_activate), url.merge(:user => {:status => User::STATUS_ACTIVE}), :method => :put, :class => 'icon icon-unlock') +
          link_to(l(:button_lock), url.merge(:user => {:status => User::STATUS_LOCKED}), :method => :put, :class => 'icon icon-lock')
        elsif user != User.current
          link_to l(:button_lock), url.merge(:user => {:status => User::STATUS_LOCKED}), :method => :put, :class => 'icon icon-lock'
        end
      end
    end
  end
end
