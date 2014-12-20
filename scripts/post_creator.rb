#!/usr/bin/env ruby

require "pathname"
require "optparse"
require "ostruct"
require "time"
require "stringex"

APP_NAME = "Post Creator"
APP_VERSION = "1.0.0"
DEFAULT_EDITOR = "vim"

options = OpenStruct.new
options.editor = DEFAULT_EDITOR
options.draft = false
options.tag = []
options.category = []
options.template = ["post"]

opt_parser = OptionParser.new do |opts|
  opts.program_name = APP_NAME
  opts.version = APP_VERSION
  opts.banner = "Usage: post_creator [OPTIONS] <post title>"
  opts.separator ""
  opts.separator "OPTIONS:"
  opts.on("-d", "--datetime \"YYYY-MM-DD hh:mm:ss\"",
                "Assign the post timestamp, the default value is the current datetime. If only YYYY-MM-DD is given, hh:mm:ss would use the current time.") do |dt|
    options.datetime = dt
  end
  opts.on("-t", "--tag tag1,tag2,tag3", Array,
                "Assign the post tags.") do |tag|
    options.tag = tag
  end
  opts.on("-c", "--category category1,category2,category3", Array,
                "Assign the post categories.") do |category|
    options.category = category
  end
  opts.on("-l", "--link permlink",
                "Assign the post permlink. If no permlink is given, it would use <post title>.to_url by default.") do |link|
    options.link = link
  end
  opts.on("-T", "--template template1,template2,template3", Array,
                "Assign the templates to support. The default value is \"post\".") do |template|
    options.template = template
  end
  opts.on("-D", "--draft", "Create a draft instead, the file would be stored in src/drafts/.") do |d|
    options.draft = d
  end
  opts.on("-e", "--editor editor",
                "The editor to edit the post, the default editer is #{DEFAULT_EDITOR}.") do |editor|
    options.editor = editor
  end
  opts.on("-V", "--verbose",
                "Show debug message when running this program.") do |v|
    options.debug = v
  end
  opts.on_tail("-v", "--version", "Show version.") do
    puts opts.ver
    exit
  end
  opts.on_tail("-h", "--help", "Show help.") do
    puts opts
    exit
  end
end

opt_parser.parse!(ARGV)
if ARGV.size < 1
  puts "ERROR: No <post title> is given."
  puts opt_parser.help
  exit 1
end

if options.debug
  puts "DEBUG: options = #{options}"
  puts "DEBUG: ARGV = #{ARGV}"
end

post = OpenStruct.new
post.title = ARGV.join(" ")
post.tag = options.tag.join(" ")
post.category = options.category.join(" ")
post.template = options.template.join(" ")
if options.datetime
  post.datetime = Time.parse(options.datetime)
  if post.datetime.strftime("%H%M%S") == "000000"
    post.datetime = Time.parse("#{options.datetime} #{Time.now.strftime("%T")}")
  end
else
  post.datetime = Time.now
end
if options.link
  post.link = options.link
else
  post.link = ARGV.join(" ").to_url
end
post.name = "#{post.datetime.strftime("%F-%H%M%S")}-#{post.link}"

if options.debug
  puts "DEBUG: post = #{post}"
end

file_header = <<eos
.meta
  .title #{post.title}
  .datetime #{post.datetime.strftime("%F %T")}
  .tag #{post.tag}
  .category #{post.category}
  .link #{post.link}
  .file #{post.name}
  .template #{post.template}
#{options.draft ? "  .draft" : ""}

eos

if options.template.include?("gem")
  file_header = file_header + <<eos
ul
  li
    a href="" target="_blank" Homepage
  li
    a href="" target="_blank" Github
  li
    a href="" target="_blank" RubyGem
    code
      |  ()
h1 What
p
  | 
h1 Why
p
  | 
h1 How
p
  | 
div hljs="" include="'code1'"
script type="text/ng-template" id="code1"
  | 
eos
end

root_path = Pathname.new(File.dirname(__FILE__)) + ".."

target_file = root_path + "src/posts/#{post.name}.slim"

File.open(target_file, "w") do |file|
  file.write(file_header)
end

if options.editor == "vim"
  system("vim #{target_file} +10")
else
  system("#{options.editor} #{target_file}")
end
