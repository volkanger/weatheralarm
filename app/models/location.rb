class Location < ActiveRecord::Base
    validates :zipcode, uniqueness: true
end
