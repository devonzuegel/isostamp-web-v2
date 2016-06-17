module ApplicationHelper
  def formatted_time_ago(time)
    "#{time_ago_in_words(time)} ago".capitalize
  end

  def disabled(text)
    content_tag :i, :class => 'grey' do
      text
    end
  end

  def split_into_halves(array)
    col_length = (array.length / 2) + (array.length % 2)
    array.in_groups_of(col_length, false)
  end
end
