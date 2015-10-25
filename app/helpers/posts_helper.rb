module PostsHelper
  def next_button(post)
    next_post = post.next
    next_post ? link_to("Next Post", next_post) : nil
  end

  def prev_button(post)
    prev_post = post.previous
    prev_post ? link_to("Previous Post", prev_post) : nil
  end

  def raw_link(post)
    link_to("View Raw", post_path(post, format: :text))
  end

  def tag_link(post)
    link_to("#{post.tag.name}", posts_path(tag_id: post.tag.id), class: "tag")
  end

  def author_link(post)
    link_to("By #{post.author.username}", author_path(post.author), class: "author")
  end

  def likes_count(post)
    pluralize(post.likes, 'like')
  end

  def like_button(post)
    link_to(likes_count(post) + " " + like_action(post), like_path(post), method: "PUT", remote: true, data: {id: post.id}, class: "like")
  end

  def like_action(post)
    return "(Like)" unless session && (session[:liked] || session["liked"])
    (session[:liked][post.id] || session[:liked][post.id.to_s]) ? "(Unlike)" : "(Like)"
  end
end
