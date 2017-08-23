class Mention < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # validates uniqueness of user and post 
end
