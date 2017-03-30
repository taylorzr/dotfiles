Regular Expressions
===================

###### Look around
```
(?<=something) # Positive lookbehind
(?<!something) # Negative lookbehind
(?=something)  # Positive lookahead
(?!something)  # Negative lookahead
```


Ruby Gem
========

###### Create a new gem
`bundle gem <GEM_NAME>` # http://bundler.io/rubygems.html

###### Publish a gem
```
# First increase the version number then:
$ gem build <GEM_NAME>.gemspec
$ gem push <GEM_NAME>
# e.g.
$ gem build verbalize.gemspec
$ gem push verbalize-2.1.0.gem
```

###### Yank a published gem version
```
$ gem yank <GEM_NAME> -v <VERSION_NUMBER>
# e.g.
$ gem yank verbalize -v 2.0.2
```


Shell
=====

###### Search shell command history
```
Control-r # backward
Control-s # forward
```

###### Show ruby documentation
```
rvm docs generate # Just needed once, and I guess again when a gem or
something changes
ri Array#empty?
```

Git
===

###### Rebase first commit
`git rebase -i --root master`

###### Delete tag
```
$ git tag -d <tag>
$ git push origin :refs/tags/<tag>
```

###### Show only commits in my branch
```
git log origin/master..
git log origin/master..HEAD
```

###### Show only PR merge commits in master branch
`git log --first-parent`


SSL
===

###### Verify ssl is configured properly
`openssl s_client -connect domain:443`


Printing
========

###### Print without newline
```
print -n hello
echo -n hello
```
