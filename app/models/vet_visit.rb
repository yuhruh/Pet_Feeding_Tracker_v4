class VetVisit < ApplicationRecord
  attr_accessor :member_emails

  belongs_to :pet

  has_many :vet_visit_members, dependent: :destroy
  has_many :members, through: :vet_visit_members, source: :user

  validates :question, presence: true
  validates :visit_date, presence: true

  before_save :set_answered_date
  after_save :sync_vet_metadata, if: -> { saved_change_to_vet_name? || saved_change_to_consultation_time? }

  private

  def sync_vet_metadata
    pet.vet_visits.where(visit_date: visit_date).where.not(id: id).update_all(
      vet_name: vet_name,
      consultation_time: consultation_time
    )
  end

  def set_answered_date
    if answer.present? && answered_date.blank?
      self.answered_date = Date.today
    elsif answer.blank?
      self.answered_date = nil
    end
  end
end
