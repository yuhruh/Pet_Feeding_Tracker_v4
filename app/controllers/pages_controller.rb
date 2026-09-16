class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :hero_section, :about, :doc, :privacy, :terms ]
  before_action :resume_session, only: [ :hero_section ]

  def hero_section
    redirect_to pets_path if authenticated?
  end

  def doc
  end

  # Linked from the footer and given to Google as the app's privacy policy and terms.
  def privacy
  end

  def terms
  end
end
