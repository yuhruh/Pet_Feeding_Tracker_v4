class VetVisitsController < ApplicationController
  before_action :require_authentication
  before_action :set_pet
  before_action :set_vet_visit, only: %i[show edit update destroy]
  before_action :verify_access!, only: %i[show edit update destroy]
  before_action :verify_owner!, only: %i[new create destroy]

  def index
    if @pet.user == Current.user
      @vet_visits = @pet.vet_visits.order(visit_date: :desc)
    else
      @vet_visits = @pet.vet_visits.joins(:vet_visit_members).where(vet_visit_members: { user_id: Current.user.id }).order(visit_date: :desc)
      if @vet_visits.empty?
        redirect_to pets_path, alert: t("vet_visits.unauthorized")
      end
    end
  end

  def show
  end

  def new
    @vet_visit = @pet.vet_visits.build
  end

  def create
    @vet_visit = @pet.vet_visits.build(vet_visit_params)

    if @vet_visit.save
      sync_members
      redirect_to pet_vet_visits_path(@pet), notice: t(".notice")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @vet_visit.update(vet_visit_params)
      sync_members if @pet.user == Current.user # Only owner can modify members
      redirect_to pet_vet_visits_path(@pet), notice: t(".notice")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def batch_update
    visits_data = params[:vet_visits] || {}
    @errors = []

    ActiveRecord::Base.transaction do
      visits_data.each do |visit_id, visit_params|
        visit = @pet.vet_visits.find_by(id: visit_id)
        unless visit
          @errors << t("vet_visits.not_found", default: "Vet visit not found")
          raise ActiveRecord::Rollback
        end

        unless @pet.user == Current.user || visit.members.include?(Current.user)
          @errors << t("vet_visits.unauthorized")
          raise ActiveRecord::Rollback
        end

        permitted = if @pet.user == Current.user
                      visit_params.permit(:question, :answer, :visit_date)
        else
                      visit_params.permit(:answer)
        end

        unless visit.update(permitted)
          @errors += visit.errors.full_messages.map { |msg| "#{visit.visit_date}: #{msg}" }
          raise ActiveRecord::Rollback
        end
      end
    end

    if @errors.empty?
      redirect_to pet_vet_visits_path(@pet), notice: t(".notice", default: "All changes saved successfully!")
    else
      if @pet.user == Current.user
        @vet_visits = @pet.vet_visits.order(visit_date: :desc)
      else
        @vet_visits = @pet.vet_visits.joins(:vet_visit_members).where(vet_visit_members: { user_id: Current.user.id }).order(visit_date: :desc)
      end
      flash.now[:alert] = @errors.uniq.join(", ")
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @vet_visit.destroy
    redirect_to pet_vet_visits_path(@pet), notice: t(".notice")
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_vet_visit
    @vet_visit = @pet.vet_visits.find(params[:id])
  end

  def verify_access!
    unless @pet.user == Current.user || @vet_visit.members.include?(Current.user)
      redirect_to pets_path, alert: t("vet_visits.unauthorized")
    end
  end

  def verify_owner!
    unless @pet.user == Current.user
      redirect_to pets_path, alert: t("vet_visits.unauthorized_owner")
    end
  end

  def vet_visit_params
    params.expect(vet_visit: [ :question, :answer, :visit_date, :answered_date, { member_emails: [] } ])
  end

  def sync_members
    emails = params[:vet_visit][:member_emails] || []
    emails = emails.map(&:strip).reject(&:blank?).uniq

    users = User.where(email_address: emails)

    missing_emails = emails - users.map(&:email_address)
    if missing_emails.any?
      flash[:alert] = t("vet_visits.emails_not_found", emails: missing_emails.join(", "))
    end

    @vet_visit.members = users
  end
end
