class Menber < ApplicationRecord
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :menber
  
  def follow(other_menber)
    unless self == other_menber
      self.relationships.find_or_create_by(follow_id: other_menber.id)
    end
  end

  def unfollow(other_menber)
    relationship = self.relationships.find_by(follow_id: other_menber.id)
    relationship.destroy if relationship
  end

  def following?(other_menber)
    self.followings.include?(other_menber)
  end

end
