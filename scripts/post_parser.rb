#!/usr/bin/env ruby

require "pathname"
require "nokogiri"
require "stringex"
require "json"
require "optparse"
require "ostruct"
require "yaml"

APP_NAME = "Post Parser"
APP_VERSION = "1.0.0"

$options = OpenStruct.new
$options.skip_draft = true
$options.debug = false

opt_parser = OptionParser.new do |opts|
  opts.program_name = APP_NAME
  opts.version = APP_VERSION
  opts.banner = "Usage: post_parser [OPTIONS]"
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

MUST_HAVE_META = ["title", "datetime", "file"]

ROOT_PATH = Pathname.new(File.dirname(__FILE__)) + ".."

$parse_result = {
  posts: [],
  categories: {},
  tags: {}
}

def parse_post(file_path, is_draft = false)
  post_hash = {}
  post_file = File.open(ROOT_PATH + file_path)
  post_html = Nokogiri::HTML(post_file, nil, 'UTF-8')

  # parse meta
  post_html.css(".meta div").each do |meta|
    key = meta.attributes['class'].value
    value = meta.content
    case key
    when "title", "datetime"
      post_hash[key] = value
    when "tag", "category", "template"
      post_hash[key] = value.split
    when "draft"
      post_hash[key] = true
    else
      post_hash[key] = value
    end
  end
  post_hash["draft"] = true if is_draft
  if post_hash["link"] == nil and post_hash["title"]
    post_hash["link"] = post_hash["title"].to_url
  end

  # skip draft
  return if $options.skip_draft and post_hash["draft"]

  # check must-have meta
  has_error = false
  MUST_HAVE_META.each do |mm|
    unless post_hash.keys.include?(mm)
      puts "ERROR: #{file_path}: No \"#{mm}\" is found."
      has_error = true
    end
  end
  if has_error
    puts "ERROR: #{file_path}: Skip this post."
    return
  end

  # handle category and tag
  if post_hash["category"]
    post_hash["category"].each do |ca|
      if $parse_result[:categories][ca]
        $parse_result[:categories][ca][:count] += 1
      else
        $parse_result[:categories][ca] = { name: ca, count: 1 }
      end
    end
  end
  if post_hash["tag"]
    post_hash["tag"].each do |tag|
      if $parse_result[:tags][tag]
        $parse_result[:tags][tag][:count] += 1
      else
        $parse_result[:tags][tag] = { name: tag, count: 1 }
      end
      # find parent tag, such as "a" and "a_b" for "a_b_c"
      acc_tag_arr = []
      tag.split("_").each do |sub_tag|
        acc_tag_arr << sub_tag
        acc_tag = acc_tag_arr.join("_")
        if acc_tag == tag
          break
        else
          unless $parse_result[:tags][acc_tag]
            $parse_result[:tags][acc_tag] = { name: acc_tag, count: 0 }
          end
        end
      end
    end
  end

  $parse_result[:posts] << post_hash
  #relative_path =  Pathname.new(css_file).relative_path_from(css_path).to_s
  #css_files << "../css/#{relative_path}"
end

def run
  js_const_path = ROOT_PATH + "temp/js/consts"
  post_path = ROOT_PATH + "app/posts"
  draft_path = ROOT_PATH + "app/drafts"

  Dir[post_path + "**/*.html"].each do |file_path|
    parse_post(file_path)
  end

  Dir[draft_path + "**/*.html"].each do |file_path|
    parse_post(file_path, true)
  end

  if $options.debug
    puts "DEBUG: parse_result = #{$parse_result.to_yaml}"
  end

  File.open(js_const_path + "app_data.js", 'w') do |fo|
    fo.write("APP_DATA = {};")
    fo.write("APP_DATA.posts = #{$parse_result[:posts].to_json};")
    fo.write("APP_DATA.tags = #{$parse_result[:tags].to_json};")
    fo.write("APP_DATA.categories = #{$parse_result[:categories].to_json};")
  end
end

run()
