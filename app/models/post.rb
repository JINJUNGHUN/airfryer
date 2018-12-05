class Post < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true # 포스트를 삭제하면 ingredients도 같이 삭제 하겠다.

  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true # 포스트를 삭제하면 steps도 같이 삭제 하겠다.

end
