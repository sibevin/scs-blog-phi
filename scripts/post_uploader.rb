#!/usr/bin/env ruby

require "pathname"
require "nokogiri"
require "stringex"
require "json"
require "optparse"
require "ostruct"
require "yaml"

APP_NAME = "Uploader"
APP_VERSION = "1.0.0"

ROOT_PATH = Pathname.new(File.dirname(__FILE__)) + ".."

TEMP_FOLDER = ROOT_PATH + "temp"

SOURCE_REPO = {
  url: "git@github.com:sibevin/scs-blog.git",
  branch: "master"
}

PAGE_REPO = {
  url: "git@github.com:sibevin/sibevin.github.io.git",
  folder: "sibevin.github.io",
  branch: "master"
}

$options = OpenStruct.new
$options.skip_draft = true
$options.debug = false

opt_parser = OptionParser.new do |opts|
  opts.program_name = APP_NAME
  opts.version = APP_VERSION
  opts.banner = "Usage: uploader [OPTIONS]"
  opts.separator ""
  opts.separator "OPTIONS:"
  opts.on("-d", "--[no-]draft", "Parse draft posts(posts in the draft/ folder or marked with draft meta)") do |d|
    $options.skip_draft = !d
  end
  opts.on("-V", "--[no-]verbose",
                "Show debug message when running this program.") do |v|
    $options.debug = v
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

if $options.debug
  puts "DEBUG: options = #{$options}"
  puts "DEBUG: ARGV = #{ARGV}"
end

=begin
source_folder = TEMP_FOLDER + "scs-blog"

unless File.directory?(source_folder)
  Dir.chdir(TEMP_FOLDER)
  system("git clone #{SOURCE_REPO[:url]} -b #{SOURCE_REPO[:branch]}")
end

Dir.chdir(source_folder)
system("git pull origin #{SOURCE_REPO[:branch]}")
system("bundle")
require 'guard'
Guard.setup
Guard.start({ no_interactions: true })
slim_guard = Guard.guards('slim')
slim_guard.start
slim_guard.run_all
system("./script/post_parser.rb")
=end
system("#{ROOT_PATH + "scripts/post_parser.rb -V"} #{$options.skip_draft ? '' : '-d'}")

source_folder = TEMP_FOLDER + PAGE_REPO[:folder]
unless File.directory?(source_folder)
  Dir.chdir(TEMP_FOLDER) do
    system("git clone #{PAGE_REPO[:url]} -b #{PAGE_REPO[:branch]}")
  end
end
system("cp -rf #{ROOT_PATH + "app/*"} #{source_folder}")
Dir.chdir(source_folder) do
  system("git status")
  puts "What files do you want to upload ?(enter to abort)"
  puts "1. js"
  puts "2. post"
  puts "3. all"
  start_upload = gets.chomp
  is_added = false
  start_upload.split(',').each do |su|
    case su
      when "1", "js"
        system("git add js/")
        is_added = true
      when "2", "post"
        system("git add posts/")
        is_added = true
      when "3", "all"
        system("git add js/")
        puts "upload js"
        system("git add posts/")
        is_added = true
      else
        puts "Abort."
    end
  end
  if is_added
    system("git commit -v")
    system("git push origin #{PAGE_REPO[:branch]}")
  end
end
