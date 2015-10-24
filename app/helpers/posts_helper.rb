module PostsHelper
  def next_button(post)
    next_post = post.next
    next_post ? link_to("Next Post", next_post) : nil
  end

  def prev_button(post)
    prev_post = post.previous
    prev_post ? link_to("Previous Post", prev_post) : nil
  end
end
