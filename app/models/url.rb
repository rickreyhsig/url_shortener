class Url < ActiveRecord::Base
    before_save :create_short_url

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
        short = [*('a'..'z'),*('1'..'9'),*('A'..'Z')].shuffle[0,6].join
        unless check_all_short_urls(short)
            create_short_url
        else
            #if (check for bad words)
            self.short_url = short
        end
    end

    def self.search(search)
      search2 = search.to_s.gsub '0', 'O'
      if search
        where('long_url LIKE ? OR short_url LIKE ?', "%#{search}%", "%#{search2}%")
      else
        where(nil)
      end
    end

end
