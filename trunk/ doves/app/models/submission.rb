class Submission < ActiveRecord::Base

has_many :multimedia

belongs_to :bird
belongs_to :user

validates :common_name, :presence => true
validates :s_degree, :presence => true
validates :age, :presence => true
validates :sex, :presence => true
validates :plumage, :presence => true
validates :location, :presence => true
validates :region, :presence => true
validates :sight_date_time, :presence => true
validates :habitat, :presence => true
validates :gps, :presence => true
validates :coobservers, :presence => true
validates :length_of_obs, :presence => true
validates :distance_from, :presence => true
validates :detailed_description, :presence => true
validates :detailed_behavior, :presence => true
validates :distinguished_char, :presence => true
validates :prev_bird_exp, :presence => true
validates :optical_equipment, :presence => true
validates :references, :presence => true
validates :sub_recall, :presence => true
validates :guide_use, :presence => true
validates :unusual, :presence => true

def self.subsearch(search, option)
  search_condition = "%" + search + "%"
  #Submission.joins(:bird, :user).where("birds.common_name LIKE ? || users.first_name LIKE ? || users.last_name LIKE ? || users.email LIKE ?", search_condition)
  if option == "common_name"
  Submission.joins(:bird).where("birds.common_name LIKE ?", search_condition)
  end
  if option == "first_name"
  Submission.find(:all, :conditions => ['sub_fname LIKE ?', search_condition])
  end
  if option == "last_name"
  Submission.find (:all, :conditions => ['sub_lname LIKE ?', search_condition])
  end 
  if option == "email"
  Submission.find (:all, :conditions => ['email LIKE ?', search_condition])
  end
 end
end