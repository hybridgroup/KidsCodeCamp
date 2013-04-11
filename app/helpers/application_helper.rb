module ApplicationHelper
  def gravatar(user, opts = {:size => 28})
    opts[:html] ||= {:alt => user.username, :class => 'gravatar'}
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    image_tag("http://gravatar.com/avatar/#{gravatar_id}.png?s=#{opts[:size]}", opts[:html])
  end
end