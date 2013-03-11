module Helpers

  def rating_for(rateable_obj, dimension=nil, options={})
    if options && options.has_key?(:user)
      klass = rateable_obj.rates.where(:rater_id => options[:user])
      avg = klass.average(:stars).to_i
    else
      klass = dimension.nil? ? rateable_obj.average : rateable_obj.average(dimension)
      avg = klass.nil? ? 0 : klass.avg
    end
    content_tag :div, nil, "data-dimension" => dimension, :class => "star", "data-rating" => avg,
                           "data-id" => rateable_obj.id, "data-classname" => rateable_obj.class.name,
                           "data-star-count" => (options[:star] || 5)
  end
end

class ActionView::Base
  include Helpers
end