# The page a caregiver's invitation link opens: sign up with the invited email,
# or sign in (with a password, Google or LINE) and join. The token is kept in the
# session so signing in elsewhere still accepts it (HouseholdArrival).
class HouseholdJoinsController < ApplicationController
  include HouseholdArrival

  allow_unauthenticated_access
  rate_limit to: 10, within: 1.hour, only: :create,
             with: -> { redirect_to join_household_path(token: params[:token]), alert: t("household_joins.create.rate_limited") }
  before_action :resume_session
  before_action :set_invitation

  def show
    session[:invitation_token] = params[:token]
    @user = User.new(email_address: @invitation.email)
  end

  def create
    authenticated? ? join_as_current_user : sign_up_and_join
  end

  private

  def set_invitation
    @invitation = HouseholdInvitation.find_by_token(params[:token])
    return if @invitation&.pending?

    session.delete(:invitation_token)
    render :expired, status: :not_found
  end

  def join_as_current_user
    session.delete(:invitation_token)
    if @invitation.accept!(Current.user)
      redirect_to today_path, notice: t("household_joins.joined", household: helpers.household_name(@invitation.household))
    else
      redirect_to join_household_path(token: params[:token]), alert: @invitation.errors.map(&:message).to_sentence
    end
  end

  # The email is the invited one, whatever the form sends.
  def sign_up_and_join
    @user = User.new(sign_up_params.merge(email_address: @invitation.email, email_address_confirmation: @invitation.email, sign_in_count: 1))
    if @user.save
      start_new_session_for @user
      UserMailer.with(user: @user).welcome_email.deliver_later
      join_as_current_user
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :show, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.expect(user: [ :username, :password, :password_confirmation, :timezone ])
  end
end
