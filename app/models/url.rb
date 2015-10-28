class Url < ActiveRecord::Base
    before_save :create_short_url


    def check_diff(string)


    end

    def create_short_url
        short = [*('a'..'z'),*('1'..'9'),*('A'..'Z')].shuffle[0,6].join
        unless check_diff(short)
            self.short_url = 'rkreyhsig/' + short
        else
            create_short_url
        end
    end
end
