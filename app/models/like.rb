class Like < ApplicationRecord
  belongs_to :object, polymorphic:true
end
