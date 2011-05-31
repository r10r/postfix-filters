#!/usr/bin/env ruby


module Postfix

  module PipedFilter
    
    # removes all Reply-To headers in the given input and 
    # adds a new Reply-To header for the given reply_to_address.
    # the processed input is written to the given IO object/subprocess
    def self.filter_reply_to(input, reply_to_address, command)
    
      in_header = true
      
      open(command, "w") do |process|
        # write reply to header to process
        process.puts "Reply-To: #{reply_to_address}"

        input.each_line do |line|
          
          # check if we are still processing the message header
          if in_header

            if line.chomp.empty?
              in_header = false
            end
            
            # skip existing reply-to headers
            if line =~ /^Reply-To: .*$/i
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
  # adds a Reply-To header with the recipient adress
  sender, recipient = ARGV
  command = "| /usr/sbin/sendmail -f %s -- %s" % [sender,recipient]
  Postfix::PipedFilter.filter_reply_to(STDIN, recipient, command)
end
