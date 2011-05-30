#!/usr/bin/env ruby


module Postfix

  module PipedFilter
    
    def self.replace_replyto(input, sender, recipient, command)
    
      in_header = true

      # read stdin and replace all existing reply-to fields
      open(command, "w") do |process|
        # write reply to header to process
        process.puts "Reply-To: #{recipient}"

        input.each_line do |line|
          
          if in_header

            if line.chomp.empty?
              in_header = false
            end
            
            if line =~ /^Reply-To: .*$/i
              # skip line
              next
            end

          end
          # write line to to process
          process.write line
        end
      end
    end
    
  end
end

if __FILE__ == $0
  sender, recipient = ARGV
  command = "| sendmail -f %s -- %s" % [sender,recipient]
  ReplyTo.process(STDIN, sender,recipient, command)
end
