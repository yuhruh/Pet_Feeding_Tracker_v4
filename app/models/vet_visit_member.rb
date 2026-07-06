class VetVisitMember < ApplicationRecord
  belongs_to :vet_visit
  belongs_to :user

  validates :user_id, uniqueness: { scope: :vet_visit_id }
end
