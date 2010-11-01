# SqlFunk

require 'active_record'

module SqlFunk
  # def self.included(base)
  #   base.send :extend, ClassMethods
  # end
  
  module Base
    
    def count_by(column_name, options = {})
      options[:order] ||= 'ASC'
      options[:group_by] ||= 'day'
      options[:group_column] ||= options[:group_by]

      date_func = case options[:group_by]
      when "day"
        case ActiveRecord::Base.connection.adapter_name.downcase
        when "sqlite" then "STRFTIME(\"%Y-%m-%d\", #{column_name})"
        when "mysql" then "DATE(#{column_name})"
        when "postgresql" then "DATE_TRUNC('day', #{column_name})"
        end
      when "month"
        case ActiveRecord::Base.connection.adapter_name.downcase
        when "sqlite" then "STRFTIME(\"%Y-%m\", #{column_name})"
        when "mysql" then "DATE_FORMAT(#{column_name}, \"%Y-%m\")"
        when "postgresql" then "DATE_TRUNC('month', #{column_name})"
        end
      when "year"
        case ActiveRecord::Base.connection.adapter_name.downcase
        when "sqlite" then "STRFTIME(\"%Y\", #{column_name})"
        when "mysql" then "DATE_FORMAT(#{column_name}, \"%Y\")"
        when "postgresql" then "DATE_TRUNC('year', #{column_name})"
        end
      end

      self.select("#{date_func} AS #{options[:group_column]}, COUNT(*) AS count_all").group(options[:group_column]).order("#{options[:group_column]} #{options[:order]}")
    end
    # 
    # def method_missing(id, *args, &block)
    # 
    #   return count_by(args[0], { :group_by => "day" }.merge(args[1]))
    # 
    #   # return count_by(args[0], { :group_by => "day" }.merge(args[1])) if id.id2name == /count_by_day/
    #   #     
    #   # return count_by(args[0], { :group_by => Regexp.last_match(1) }.merge(args[1])) if id.id2name =~ /count_by_(.+)/
    # 
    # end
    
  end

end
