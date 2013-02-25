module SitesHelper
  
  def logo_url
    root_url + "/logo_mini.png"
  end
  
  def button_position id
    
    x = 100
    y = 60
    offset = 10
    half_x = x / 2;
    
    if(id == 0)
      "top: -#{offset}px; left: #{offset}px; width: #{x}px; height: #{y}px;"
    elsif(id == 1)
      "top: -#{offset}px; left: 50%; margin-left: -#{half_x}px; width: #{x}px; height: #{y}px;"
    elsif(id == 2)
      "top: -#{offset}px; right: #{offset}px; width: #{x}px; height: #{y}px;"
    elsif(id == 3)
      "left: -#{offset}px; top: 40%; width: #{x}px; height: #{y}px;"
    elsif(id == 4)
      "right: -#{offset}px; top: 40%; width: #{y}px; height: #{x}px;"
    elsif(id == 5)
      "bottom: -#{offset}px; left: #{offset}px; width: #{x}px; height: #{y}px;"
    elsif(id == 6)
      "bottom: -#{offset}px; left: 50%; margin-left: -#{half_x}px; width: #{x}px; height: #{y}px;"
    elsif(id == 7)  
      "bottom: -#{offset}px; right: #{offset}px; width: #{x}px; height: #{y}px;"
    else
      ""
    end
  end
  
end
