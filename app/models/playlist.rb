class Playlist < ActiveRecord::Base
  validates_uniqueness_of :spoti_id
  belongs_to :user
end
