class Url < ActiveRecord::Base
    require 'digest'
    before_save :create_short_url

    BAD_WORDS = ['shit', 'fuck', 'damn', 'bitch', 'ass']

    def self.search(search)
      search2 = search.to_s.gsub '0', 'O'
      if search
        where('long_url LIKE ? OR short_url LIKE ?', "%#{search}%", "%#{search2}%")
      else
        where(nil)
      end
    end

    protected

    def check_diff(a, b)
        cnt = 0
        (0..(a.length)).each do |i|
           cnt = cnt+1 if a[i] != b[i]
        end
        return cnt
    end

    def check_all_short_urls(shrt)
        Url.all.each do |url|
            if check_diff(shrt, url.short_url) <= 1
                return false
            end
        end
    end

    def create_short_url
        short = Digest::MD5.hexdigest(self.long_url+"a shortening salt").slice(0..6)
        short.gsub '0', 'O'

        # Recalculate short url in case a duplicate is found or a curse word is found
        if ( (check_all_short_urls(short) == false) || (BAD_WORDS.include? short.downcase) )
            self.long_url = self.long_url + '_'
            create_short_url
        else
            self.short_url = short
        end
    end

end
