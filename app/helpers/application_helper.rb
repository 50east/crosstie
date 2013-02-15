module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def javascript_manifest(manifest)
    content_for(:javascript) { javascript_include_tag manifest.to_sym }
  end

  def body_class(html_class)
    content_for(:body_class) { html_class }
  end

  def meta_description(description)
    content_for(:meta_description) { description }
  end

  def meta_keywords(keywords)
    content_for(:meta_keywords) { keywords }
  end

  def meta_twitter_title(title)
    content_for(:meta_twitter_title) { title }
  end

  def meta_twitter_description(description)
    content_for(:meta_twitter_description) { description }
  end
  def meta_og_title(title)
    content_for(:meta_og_title) { title }
  end

  def meta_og_description(description)
    content_for(:meta_og_description) { description }
  end

  def bootstrap_alert_class(type, multiline = false)

    color_class = case type
    when :notice
      'alert-success'
    when :error
      'alert-error'
    else
      ''
    end

    html_class = "alert #{color_class}"
    html_class << 'alert-block' if multiline

    html_class
  end
end
