class ErrorsController < ApplicationController
  def not_found
    original_path = request.env['ORIGINAL_FULLPATH']

    if r = (Redirect.find_by_from_path("#{original_path}") || Redirect.find_by_from_path("#{original_path}/"))
      r.increment! :clicks
      redirect_to r.to_url, status: :moved_permanently
    end
  end

  def internal_error
  end
end
