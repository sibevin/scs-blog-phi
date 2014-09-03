#!/usr/bin/env ruby

require "pathname"
require "json"

root_path = Pathname.new(File.dirname(__FILE__)) + ".."
css_path = root_path + "app/css"
js_const_path = root_path + "temp/js/consts"
route_config_path = root_path + "config/routes.json"
config_dir = root_path + "config"

=begin
css_files = []
Dir[css_path + "**/*.css"].each do |css_file|
  relative_path =  Pathname.new(css_file).relative_path_from(css_path).to_s
  css_files << "../css/#{relative_path}"
end

File.open(js_const_path + "css_files.js", 'w') do |f|
  f.write("CSS_FILES = [#{css_files.map {|cf| "\"#{cf}\""}.join(', ')}];")
end
=end

File.open(route_config_path, "r" ) do |f|
  File.open(js_const_path + "route.js", 'w') do |fo|
    fo.write("ROUTES = #{f.read};")
  end
end

File.open(js_const_path + "config.js", 'w') do |fo|
  Dir[config_dir + "*.json"].each do |config_file|
    File.open(config_file, 'r') do |f|
      fo.write("#{File.basename(config_file, '.json').upcase} = #{f.read};")
    end
  end
end

