class City < ApplicationRecord
  belongs_to :prefecture
  has_many :places

  validate :name, presence: true

  def self.where_like(ambiguous_name)
    return self.where(["name LIKE ? OR name LIKE ? OR name LIKE ? OR name LIKE ? OR name LIKE ?", "#{ambiguous_name}%", "%市#{ambiguous_name}", "%市#{ambiguous_name}_", "%郡#{ambiguous_name}", "%郡#{ambiguous_name}_"])
  end

  def with_prefecture_name
    return "#{self.prefecture.name}#{self.name}"
  end
end
