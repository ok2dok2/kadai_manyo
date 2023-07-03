class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :date, presence: true
  enum status: [:before, :now, :done]
  enum priority: [:low, :middle, :high]

  def self.search(search)
    return Task.all unless search
    Task.where('name LIKE(?)',"%#{search}%")
  end

  scope :key_search, -> (keyword){ search(keyword) }
  scope :select_search, -> (select){ where(status: select) }
end
