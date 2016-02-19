class Fan < ActiveRecord::Base
  validates :name, presence: true,
    format:
      { with: /\A[a-zA-Z]+\z/,
        message: "only allows uppercase and lowercase letters"}
  validates :email, presence:   true,
                    uniqueness: true,
                    length:     { in: 5..50 }
  validate :no_richards

  def no_richards
    errors.add(:name, "cannot be Richard") if name == "Richard"
  end
end
