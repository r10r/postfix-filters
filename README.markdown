# Postfix filters written in Ruby

A set of useful header/content processing filters for
postfix written in ruby.

## Filter integration in postfix header_checks

piped filter configuration in `master.cf`:

<pre>
filter_reply_to    unix  -       n       n       -       10      pipe
    flags=Rq user=filter null_sender=
    argv=/usr/local/share/postfix-filters/filter_reply_to.rb ${sender} ${recipient}
</pre>


conditional filter execution in [header_checks](http://www.postfix.org/header_checks.5.html):

<pre>
/^To: distribution-list@foo.bar/ FILTER filter_reply_to:dummy
</pre>


run `postfix reload` to reload the configuration


## manual testing

<pre>
cat testmail | ruby ./filter_reply_to.rb sender@foo.com recipient@foo.com
</pre>


## troubleshooting

- The specs currently require ruby 1.9
- sendmail must be in the PATH or fully qualified
