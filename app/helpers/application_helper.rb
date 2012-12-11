module ApplicationHelper
  def column_count item_count, item_length
  	if item_count < 10
      @cols = 1
    elsif item_length < 5
      @cols = 7
    elsif item_length < 8
      @cols =5
    else
      @cols = 3
    end
  end
end