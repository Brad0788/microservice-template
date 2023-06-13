class Role < ApplicationRecord
  acts_as_paranoid
    #Validation Rules
    validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
    validates :description, presence: true, length: { maximum: 100 }

    before_create :assign_created_date

    private

    def assign_created_date
      self.created_date = Time.now.utc
    end
end
