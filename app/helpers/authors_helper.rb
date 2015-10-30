module AuthorsHelper
  def field_with_errors(object, field)
    if object.errors[field].empty?
      ""
    else
      content_tag(:div, class: "error") do
        field.to_s.titleize + " " + object.errors[field].first
      end
    end
  end
end
