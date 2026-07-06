class VetVisit < ApplicationRecord
  attr_accessor :member_emails

  belongs_to :pet

  has_many :vet_visit_members, dependent: :destroy
  has_many :members, through: :vet_visit_members, source: :user

  validates :question, presence: true
  validates :visit_date, presence: true

  before_save :set_answered_date

  private

  def set_answered_date
    if answer.present? && answered_date.blank?
      self.answered_date = Date.today
    elsif answer.blank?
      self.answered_date = nil
    end
  end
end
