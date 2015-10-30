def check_diff(a, b) # Checks the diffent characters in two strings
    cnt = 0
    (0..(a.length)).each do |i|
       cnt = cnt+1 if a[i] != b[i]
    end
    return cnt
end

def check_all_short_urls(shrt)
    Url.all.each do |url|
        puts shrt + ' '  + url.short_url + ' ' + check_diff(shrt, url.short_url).to_s
        if check_diff(shrt, url.short_url) <= 1
            return false
        end
    end
end

puts 'Repeat' unless check_all_short_urls('YeVhST')
puts 'Repeat' unless check_all_short_urls('YeVh89')
puts 'Repeat' unless check_all_short_urls('AJuwzW')
puts 'Repeat' unless check_all_short_urls('k8PbfC')
puts 'Repeat' unless check_all_short_urls('unqb4y')
puts 'Repeat' unless check_all_short_urls('U3DqZK')
puts 'Repeat' unless check_all_short_urls('U3DqZ9')