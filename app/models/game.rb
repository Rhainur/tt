class Game < ActiveRecord::Base
  belongs_to :match
  has_many :scores, dependent: :destroy
end