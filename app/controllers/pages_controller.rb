class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :hero_section, :about ]
  before_action :resume_session, only: [ :hero_section ]
end
