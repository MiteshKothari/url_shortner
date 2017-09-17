class Shortener < ApplicationRecord
 before_create :generate_dilute
 validates_presence_of :target

  # returns url + slug, i.e newly generated url
  def shorten
    return "#{Rails.application.secrets.base_url}#{self.dilute}"
  end

  # returns url with adding protocol if not added
  def target?
    if self.target.match(/^(http[s]?:\/\/)/)
      return self.target
    else
      return "http://#{self.target}"
    end
  end

  private

    # this method creates shortner slug
    def generate_dilute
      alpha = ('a'...'z').to_a
      alphau = ('A'...'Z').to_a
      num = (0...9).to_a
      alphanum = alpha+num+alphau
      found = false
      slug = ""
      until found
        slug = alphanum.shuffle[0...3].join('')
        found = Shortener.where(dilute: slug).take.nil?
      end
      self.dilute = slug
      self.hits = 0
    end
end
