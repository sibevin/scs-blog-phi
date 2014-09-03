#!/usr/bin/env ruby
post_name = "#{Time.now.strftime('%F')}-#{ARGV.join('-').downcase}"

default_fm = <<eos
---
layout: post
title:  #{ARGV.join(' ')}
date:   #{Time.now.strftime('%F %T')}
categories:
tags:   
---
eos

File.open("./_posts/#{post_name}.md", 'w') do |file|
  file.write(default_fm)
end
system("vim ./_posts/#{post_name}.md +3")
