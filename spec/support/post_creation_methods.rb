module PostCreateMethods
  def create_post(**args)
    visit new_post_path
    fill_in("Title", with: args[:title] || "My Post Title")
    fill_in("Body", with: args[:body] || "My very long post body is very long and I hope you think it's great.")
    fill_in("Tag", with: args[:tag_name] || "Ruby")
    click_button("Save Post")
  end
end
