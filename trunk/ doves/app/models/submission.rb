class Submission < ActiveRecord::Base

has_many :multimedia, :dependent => :destroy
has_many :votes
accepts_nested_attributes_for :multimedia

belongs_to :bird
belongs_to :user

# validates :common_name, :presence => true
# validates :s_degree, :presence => true
# validates :age, :presence => true
# validates :sex, :presence => true
# validates :plumage, :presence => true
# validates :location, :presence => true
# validates :region, :presence => true
# validates :sight_date_time, :presence => true
# validates :habitat, :presence => true
# validates :gps, :presence => true
# validates :coobservers, :presence => true
# validates :length_of_obs, :presence => true
# validates :distance_from, :presence => true
# validates :detailed_description, :presence => true
# validates :detailed_behavior, :presence => true
# validates :distinguished_char, :presence => true
# validates :prev_bird_exp, :presence => true
# validates :optical_equipment, :presence => true
# validates :references, :presence => true
# validates :sub_recall, :presence => true
# validates :guide_use, :presence => true
# validates :unusual, :presence => true

def self.subsearch(search, option)
  search_condition = "%" + search + "%"
  #fix for sql injection!
  case option 
	when "common_name" 
		Submission.joins(:bird).where("birds.common_name LIKE ? OR submissions.common_name LIKE ?", search_condition, search_condition)
	when "first_name"
		Submission.joins(:user).where("users.first_name LIKE ?", search_condition)
	when "last_name"
		Submission.joins(:user).where("users.last_name LIKE ?", search_condition)
	when "email"
		Submission.joins(:user).where("users.email LIKE ?", search_condition)
	else Submission.find(:all)
  end


 end
 
 def user_authorized_to_view?(user)
	if user then
	case status
		when "incomplete"
			if (user.level == "admin") or (user.id == user_id)
				true
			else
				false
			end
		when "new"
			if (user.level == "admin") or (user.id == user_id)
				true
			else
				false
			end
		when "pending"
			if (user.level == "admin") or (user.level == "reviewer") or (user.id == user_id)
				true
			else
				false
			end
		when "accepted"
			true
		when "verified"
			true
		when "rejected"
			if (user.level == "admin") or (user.level ==  "reviewer") or (user.id == user_id)
				true
			else
				false
			end
		else
			if (user.level == "admin") or (user.id == user_id)
				true
			else
				false
			end
	end
	else
		true if status == 'verified'
	end
 end
 
  def user_authorized_to_edit?(user)
	if user then
	case status
		when "incomplete"
			if (user.id == user_id)
				true
			else
				false
			end
		when "new"
			if (user.id == user_id)
				true
			else
				false
			end
		else
			if (user.level == "admin")
				true
			else
				false
			end
	end
	
	end
 end
 
 def user_authorized_to_destroy?(user)
	if user then
	case status
		when "incomplete"
			if (user.id == user_id)
				true
			else
				false
			end
		when "new"
			if (user.id == user_id)
				true
			else
				false
			end
		else
			if (user.level == "admin")
				true
			else
				false
			end
	end
	end
 end
 
 
 
end