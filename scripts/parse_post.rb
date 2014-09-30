#!/usr/bin/env ruby

require "pathname"
require "nokogiri"
require "stringex"
require "json"

MUST_HAVE_META = ["title", "datetime", "file"]

root_path = Pathname.new(File.dirname(__FILE__)) + ".."
js_const_path = root_path + "temp/js/consts"
post_path = root_path + "app/posts"

post_files = []
posts = []
tags = {}
categories = {}

Dir[post_path + "**/*.html"].each do |post_file_path|
  post_hash = {}
  post_file = File.open(root_path + post_file_path)
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
  if post_hash["link"] == nil and post_hash["title"]
    post_hash["link"] = post_hash["title"].to_url
  end

  # check must-have meta
  has_error = false
  MUST_HAVE_META.each do |mm|
    unless post_hash.keys.include?(mm)
      p "ERROR: #{post_file_path}: No \"#{mm}\" is found."
      has_error = true
    end
  end
  if has_error
    p "ERROR: #{post_file_path}: Skip this post."
    next
  end

  # handle category and tag
  if post_hash["category"]
    post_hash["category"].each do |ca|
      if categories[ca]
        categories[ca][:count] += 1
      else
        categories[ca] = { name: ca, count: 1 }
      end
    end
  end
  if post_hash["tag"]
    post_hash["tag"].each do |tag|
      if tags[tag]
        tags[tag][:count] += 1
      else
        tags[tag] = { name: tag, count: 1 }
      end
      # find parent tag, such as "a" and "a_b" for "a_b_c"
      acc_tag_arr = []
      tag.split("_").each do |sub_tag|
        acc_tag_arr << sub_tag
        acc_tag = acc_tag_arr.join("_")
        if acc_tag == tag
          break
        else
          unless tags[acc_tag]
            tags[acc_tag] = { name: acc_tag, count: 0 }
          end
        end
      end
    end
  end

  posts << post_hash
  #relative_path =  Pathname.new(css_file).relative_path_from(css_path).to_s
  #css_files << "../css/#{relative_path}"
end

p posts
p tags
p categories

File.open(js_const_path + "app_data.js", 'w') do |fo|
  fo.write("APP_DATA = {};")
  fo.write("APP_DATA.posts = #{posts.to_json};")
  fo.write("APP_DATA.tags = #{tags.to_json};")
  fo.write("APP_DATA.categories = #{categories.to_json};")
end
