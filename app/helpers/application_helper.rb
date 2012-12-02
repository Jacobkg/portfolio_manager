module ApplicationHelper

  def format_decimal(decimal)
    if decimal == decimal.round
      decimal.round
    else
      decimal
    end
  end

end
