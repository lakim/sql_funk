# SqlFunk

require 'active_record'

module SqlFunk
  # def self.included(base)
  #   base.send :extend, ClassMethods
  # end
  
  module Base
    DATE_GROUPS = %w( day month year )
    
    DATE_GROUPS.each do |group|
      count_method_name = "count_by_#{group}".to_sym
      define_method count_method_name do |column_name, options={}|
        options[:order] ||= 'ASC'
        options[:group_column] ||= group

        date_func = date_truncate(column_name, group)

        self.select("#{date_func} AS #{options[:group_column]}, COUNT(*) AS count_all").group(options[:group_column]).order("#{options[:group_column]} #{options[:order]}")       
      end
      
      
      group_method_name = "count_by_#{group}".to_sym
      define_method group_method_name  do |column_name, options={}|
        options[:order] ||= 'ASC'
        options[:group_column] ||= group

        date_func = date_truncate(column_name, group)


        self.select("#{date_func} AS #{options[:group_column]}, COUNT(*) AS count_all").group(options[:group_column]).order("#{options[:group_column]} #{options[:order]}")       
      end
      
    end

    
   
    private
    def date_truncate(column_name, group_by)
      case group_by
      when "day"
        case ActiveRecord::Base.connection.adapter_name.downcase
        when /^sqlite/ then "STRFTIME(\"%Y-%m-%d\", #{column_name})"
        when /^mysql/ then "DATE(#{column_name})"
        when /^postgresql/ then "DATE_TRUNC('day', #{column_name})"
        end
      when "month"
        case ActiveRecord::Base.connection.adapter_name.downcase
        when /^sqlite/ then "STRFTIME(\"%Y-%m\", #{column_name})"
        when /^mysql/ then "DATE_FORMAT(#{column_name}, \"%Y-%m\")"
        when /^postgresql/ then "DATE_TRUNC('month', #{column_name})"
        end
      when "year"
        case ActiveRecord::Base.connection.adapter_name.downcase
        when /^sqlite/ then "STRFTIME(\"%Y\", #{column_name})"
        when /^mysql/ then "DATE_FORMAT(#{column_name}, \"%Y\")"
        when /^postgresql/ then "DATE_TRUNC('year', #{column_name})"
        end
      end
    end
    
  end

end
