require 'rubygems'
require 'rails'
require 'test_helper'
require 'lib/sql_funk'

class SqlFunkTest < ActiveSupport::TestCase
  
  class Subscriber < ActiveRecord::Base
  end
  
  def init
    load_schema
  end

  test "plugin init" do
    init
    
    assert_equal [], Subscriber.all
  end
  
  # test "group by day" do
  #   init
  #   
  #   john = Subscriber.new(:name => "John", :created_at => '2010-11-01 07:00:00')
  #   john.save!
  #   
  #   mary = Subscriber.new(:name => "John", :created_at => '2010-11-01 08:00:00')
  #   mary.save!
  #   
  #   subscribers_per_day = Subscriber.count_by("created_at", :group_by => "day")
  #   
  #   assert_equal subscribers_per_day.count, 1
  #   assert_equal subscribers_per_day.first["day"].to_s, '2010-11-01'
  # end
end
