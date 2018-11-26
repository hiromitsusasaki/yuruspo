class SearchQuery < ApplicationRecord
  belongs_to :user
  belongs_to :contents
  belongs_to :city
end
