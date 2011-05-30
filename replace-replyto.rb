#!/usr/bin/env ruby

sender, recipient = ARGV

in_header = true

# read stdin and replace all existing reply-to fields
IO.popen("sendmail -f #{sender} -- #{recipient}", "w") do |sendmail|
  # write reply to header to sendmail
  sendmail.puts "Reply-To: #{recipient}"

  STDIN.each do |line|
    
    if in_header

      if line.chomp.empty?
        in_header = false
      end
      
      if line =~ /^Reply-To: .*$/i
        # skip line
        next
      end

    end
    # write line to to sendmail
    sendmail.write line
  end
end

