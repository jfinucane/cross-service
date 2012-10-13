class GridType < ActiveRecord::Base
  attr_accessible :row_count, :col_count, :dictionary_id, :status
end
