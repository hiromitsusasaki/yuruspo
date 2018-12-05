module Webapp::ApplicationsHelper
  def partial name
    return "webapp/partials/#{name}"
  end
end
