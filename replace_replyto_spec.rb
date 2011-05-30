require 'tempfile'
load 'replace_replyto.rb'

describe "reply-to filter" do
  it "should replace existing Reply-To Headers" do
  
    tempfile = Tempfile.new('output')
  
mail = <<-EOS
To: bob@bar.com
From: alice@bar.com
      
Dear Bob,
the weather is nice and the sky is blue!
      
Sincerely,
Alice
EOS
    
expected = <<-EOS
Reply-To: new@bar.com
To: bob@bar.com
From: alice@bar.com
      
Dear Bob,
the weather is nice and the sky is blue!
      
Sincerely,
Alice
EOS
    
    Postfix::PipedFilter.replace_replyto(mail, "", "new@bar.com", tempfile)
    
    # jump to beginning of tempfile
    tempfile.seek(0)
    
    tempfile.read.should == expected
    
  end
end
