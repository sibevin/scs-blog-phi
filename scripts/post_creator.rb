#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'

APP_VERSION = '1.0.0'

options = OpenStruct.new
options.editor = 'vim'
options.draft = false

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: ./post_creator [OPTIONS] <post name>"
  opts.separator ""
  opts.separator "OPTIONS:"
  opts.on("-d", "--datetime YYYY-MM-DD hh:mm:ss",
                "Assign the post timestamp, the default value is the current datetime. If only YYYY-MM-DD is given, hh:mm:ss would use the current time.") do |dt|
    options.datetime = dt
  end
  opts.on("-t", "--tag tag1,tag2,tag3", Array,
                "Assign the post tags.") do |tags|
    options.tags = tags
  end
  opts.on("-c", "--category category",
                "Assign the post category.") do |category|
    options.category = category
  end
  opts.on("-e", "--editor",
                "Assign the post editor, the default value is vim.") do |editor|
    options.editor = editor
  end
  opts.on("-D", "--draft", "Create a draft instead, the file would be stored in src/drafts/.") do |d|
    options.draft = d
  end
  opts.on_tail("-v", "--version", "Show version.") do
    puts "Post Creator v#{APP_VERSION}"
    exit
  end
  opts.on_tail("-h", "--help", "Show help.") do
    puts opts
    exit
  end
end

opt_parser.parse!(ARGV)

p options.inspect

exit

post_name = "#{Time.now.strftime('%F')}-#{ARGV.join('-').downcase}"

file_header = <<eos
.postmeta
  .title #{ARGV.join(' ')}
  .date #{Time.now.strftime('%F %T')}
  .tags #{options.tags.join(', ')}
  .categories #{options.category}
eos

root_path = Pathname.new(File.dirname(__FILE__)) + "/.."

if draft
  target_file = root_path + "src/drafts/#{post_name}.slim"
else
  target_file = root_path + "src/posts/#{post_name}.slim"
end

File.open(target_file, 'w') do |file|
  file.write(file_header)
end
system("vim #{target_file} +3")
