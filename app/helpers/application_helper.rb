# helpers: moving logic and formatting code outside of the views
# partials: used to consolidate redundunt pieces of HTML

module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Read-This!!!"
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
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end

  	dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end