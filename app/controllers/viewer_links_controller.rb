# The owner makes a personal viewer link, or turns one off.
class ViewerLinksController < ApplicationController
  include OwnedHousehold

  EXPIRY = { "never" => nil, "7_days" => 7.days, "30_days" => 30.days, "90_days" => 90.days }.freeze

  def create
    expires_in = EXPIRY.fetch(params[:expires_in].to_s, nil)
    link = @household.viewer_links.new(name: params[:name].to_s.strip, created_by: Current.user, expires_at: expires_in&.from_now)

    if link.save
      flash[:new_viewer_link_url] = viewer_page_url(token: link.token)
      redirect_to household_path, notice: t(".notice", name: link.name)
    else
      redirect_to household_path, alert: link.errors.map(&:message).to_sentence
    end
  end

  def destroy
    link = @household.viewer_links.find(params[:id])
    link.revoke! if link.active?
    redirect_to household_path, notice: t(".notice", name: link.name), status: :see_other
  end
end
