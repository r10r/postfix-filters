# Postfix filters written in Ruby

## Filter integration in postfix header_checks

piped filter configuration in `master.cf`:

<pre>
filter_reply_to    unix  -       n       n       -       10      pipe
    flags=Rq user=filter null_sender=
    argv=/usr/local/share/postfix-filters/filter_reply_to.rb ${sender} ${recipient}
</pre>


conditional filter execution in [header_checks](http://www.postfix.org/header_checks.5.html):

  /^To: distribution-list@foo.bar/ FILTER filter_reply_to:dummy