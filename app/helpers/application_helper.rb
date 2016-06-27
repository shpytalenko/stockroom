module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Stockroom"
    end
  end
end
