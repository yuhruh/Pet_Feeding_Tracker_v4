class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :hero_section, :about, :doc ]
  before_action :resume_session, only: [ :hero_section ]

  def hero_section
    redirect_to pets_path if authenticated?
  end

  def doc
  end
end
