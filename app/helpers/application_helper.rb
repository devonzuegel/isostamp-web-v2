module ApplicationHelper
  def formatted_time_ago(time)
    "#{time_ago_in_words(time)} ago".capitalize
  end

  def disabled(text)
    content_tag :i, :class => 'grey' do
      text
    end
  end
end
