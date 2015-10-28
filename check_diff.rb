def check_diff(a, b) # Checks the diffent characters in two strings
    cnt = 0
    (0..(a.length)).each do |i|
       cnt = cnt+1 if a[i] != b[i]
    end
    return cnt
end

Url.all.each do |url|
    puts (url.short_url)[(url.short_url).index('rkreyhsig/')+10,url.short_url.length]
end