class Location < ActiveRecord::Base
    validates :zipcode, uniqueness: true
    
    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            Location.create! row.to_hash
        end
    end
    
    def self.to_csv
        CSV.generate do |csv|
            csv << y[0]
        all.each do |product|
            csv << y[1].attributes.values_at(*column_names)
            end
        end
    end
    
end
