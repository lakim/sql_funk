require 'rails'
require 'active_record'
require 'sql_funk/base'

module SqlFunk
  # def self.included(base)
  #   base.send :extend, ClassMethods
  # end
  
  class SqlFunkRailtie < Rails::Railtie
    
    initializer 'sql_funk.extend.active_record' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.extend(SqlFunk::Base) if defined?(ActiveRecord)
      end
    end
    
  end
end
