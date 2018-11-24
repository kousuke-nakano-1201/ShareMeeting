class Relationship < ApplicationRecord
  belongs_to :menber
  belongs_to :follow, class_name: 'Menber'
end
