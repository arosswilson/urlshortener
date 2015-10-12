require 'pry'
class Url < ActiveRecord::Base
  validates :full_url, presence: true
  validate :correct_url

  #I could add more characters to the alphabet constant to shorten urls more.
  ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  BASE = 62

  def generate_short_code
    url_id = self.id
    short_code = ""
    while url_id > 0
      short_code += ALPHABET[(url_id % BASE)]
      url_id /= BASE
    end
    short_code
  end

  def domain
    return request.host_with_port if Sinatra::Application.development? || Sinatra::Application.test?
    request.host
  end

  def set_short_code
    self.short_code = generate_short_code
    self.save
  end

  def increment_count
    self.access_count += 1
    self.save
  end


  def correct_url
    if self.full_url && self.full_url.index("http://") !=0
      self.errors.add(:full_url, "must begin with http://")
    end
  end

  def month_and_day
    month = self.created_at.strftime("%b")
    day = self.created_at.strftime("%d")
    return "#{month} #{day}"
  end
end