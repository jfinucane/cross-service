module ApplicationHelper
  def column_count item_count, item_length
  	if item_count < 10
      @cols = 1
    elsif item_length < 5
      @cols = 6
    elsif item_length < 8
      @cols =4
    else
      @cols = 2
    end
  end
end