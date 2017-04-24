module ApplicationHelper
  # this is ruby not erb!!!!
  # the whole thing is a string that you call html_safe on
  # escape quotes for type, name, value
  # use string interpolation for form_authenticity_token b/c erb not ruby
  # remember to close your input tag
  # def auth_token
  #   "<input type=\"hidden\"
  #   name=\"authenticity token\"
  #   value=\"#{form_authenticity_token}\">".html_safe
  # end

  # def auth_token
  #   "<input
  #     type=\"hidden\"
  #     name=\"authenticity_token\"
  #     value=\"#{form_authenticity_token}\"
  #     >".html_safe
  # end

  def auth_token
    "<input
      type=\"hidden\"
      name=\"authenticity_token\"
      value=\"#{form_authenticity_token}\"
      >".html_safe
  end
end
