module ApplicationHelper
  def gravatar(user, opts = {:size => 28})
    opts[:html] ||= {:alt => user.username, :class => 'gravatar'}
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    image_tag("http://gravatar.com/avatar/#{gravatar_id}.png?s=#{opts[:size]}", opts[:html])
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::XHTML.new(:filter_html => true, :safe_links_only => true), :no_intra_emphasis => true)
    raw markdown.render(text).gsub(/\[youtube\s+(.*?)\]/, "<iframe class='youtube-player' type='text/html' width='550' height='330' src='http://www.youtube.com/embed/$1' allowfullscreen frameborder='0'></iframe>")
  end
end