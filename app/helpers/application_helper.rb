module ApplicationHelper

  def format_decimal(decimal)
    #Removes trailing .0 on floats if it is there
    if decimal == decimal.round
      decimal.round
    else
      decimal
    end
  end

end
