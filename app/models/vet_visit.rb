class VetVisit < ApplicationRecord
  attr_accessor :member_emails

  belongs_to :pet

  has_many :vet_visit_members, dependent: :destroy
  has_many :members, through: :vet_visit_members, source: :user

  enum :purpose, {
    vaccination: "vaccination",
    checkup: "checkup",
    dental_cleaning: "dental_cleaning",
    surgery: "surgery",
    grooming: "grooming",
    emergency: "emergency",
    follow_up: "follow_up",
    other: "other"
  }, validate: { allow_nil: true }

  validates :question, presence: true
  validates :visit_date, presence: true
  validates :waiting_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validate :waiting_time_within_consultation_time

  before_save :set_answered_date
  after_save :sync_vet_metadata, if: -> { saved_change_to_vet_name? || saved_change_to_consultation_time? || saved_change_to_waiting_time? || saved_change_to_purpose? }

  private

  def sync_vet_metadata
    pet.vet_visits.where(visit_date: visit_date).where.not(id: id).update_all(
      vet_name: vet_name,
      consultation_time: consultation_time,
      waiting_time: waiting_time,
      purpose: purpose
    )
  end

  def waiting_time_within_consultation_time
    return unless waiting_time.present? && consultation_time.present?

    if waiting_time > consultation_time
      errors.add(:waiting_time, :greater_than_consultation_time, message: I18n.t("activerecord.errors.models.vet_visit.attributes.waiting_time.greater_than_consultation_time"))
    end
  end

  def set_answered_date
    if answer.present? && answered_date.blank?
      self.answered_date = Date.today
    elsif answer.blank?
      self.answered_date = nil
    end
  end
end
