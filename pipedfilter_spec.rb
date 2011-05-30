require 'tempfile'
load 'filter_reply_to.rb'

incomming_mail = <<-EOS
To: bob@bar.com
From: alice@bar.com
Reply-To: alice@bar.com
      
Dear Bob,
the weather is nice and the sky is blue!
      
Sincerely,
Alice
EOS
    
delivered_mail = <<-EOS
Reply-To: new@bar.com
To: bob@bar.com
From: alice@bar.com
      
Dear Bob,
the weather is nice and the sky is blue!
      
Sincerely,
Alice
EOS

describe "reply-to filter" do
  it "should replace existing Reply-To header" do
  
   output = Tempfile.new('output')
    
    Postfix::PipedFilter.replace_reply_to(incomming_mail, "new@bar.com", output)
    
    # jump to beginning of tempfile
    output.seek(0)
    
    output.read.should == delivered_mail
    
  end
end
