class Lady < ActiveRecord::Base
  belongs_to :game
  belongs_to :source, :class_name => 'PlayerAssignment'
  belongs_to :target, :class_name => 'PlayerAssignment'
end
