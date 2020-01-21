class User < ActiveRecord::Base
    has_many :appointments
    has_many :bikes, through: :appointments
end