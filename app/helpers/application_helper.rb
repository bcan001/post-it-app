# helpers: moving logic and formatting code outside of the views
# partials: used to consolidate redundunt pieces of HTML

module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Post-It!!!"
    if page_title.empty?
      base_title
    else
      "#{base_title} / #{page_title}"
    end
  end

  def fix_url(str)
  	str.starts_with?("http://") ? str: "http://#{str}"
  end

  def display_datetime(dt)
  	dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end