guard :slim, slim: { disable_escape: true },
              input_root: 'src/slim',
              output_root: 'app' do
  watch(%r'^src/slim/.+\.slim$')
end

guard :slim, slim: { disable_escape: true },
              input_root: 'src/posts',
              output_root: 'app/posts' do
  watch(%r'^src/posts/.+\.slim$')
end

guard :compass, project_path: 'temp/css',
                configuration_file: 'config/compass.rb'

guard :coffeescript, :input => 'src/coffeescript',
                     :output => 'temp/js'

#ignore! /app/


module ::Guard
  class MergeCssJsGuard < ::Guard::Plugin

    OUTPUT_MIN_CSS = "app.min.css"
    OUTPUT_MIN_JS = "app.min.js"

    def initialize(options = {})
      @root_path = Pathname.new(File.dirname(__FILE__))
      super
    end

    def run_all
      merge_css_js
    end

    def run_on_changes(paths)
      merge_css_js(paths)
    end

    def run_on_modifications(paths)
      merge_css_js(paths)
    end

    def run_on_addititions(paths)
      merge_css_js(paths)
    end

    private

    def merge_css_js(paths = [])
      css_included = false
      js_included = false
      if paths.size > 0
        paths.each do |path|
          css_included = true if path.match(/css/)
          js_included = true if path.match(/js/)
        end
      else
        css_included = true
        js_included = true
      end
      merge_css if css_included
      merge_js if js_included
    end

    def merge_css
      p "Merge Css"
      p "juicer merge -d #{@root_path}/app/ -r -f #{@root_path}/temp/css/app.css -o #{@root_path}/app/css/#{OUTPUT_MIN_CSS}"
      system("juicer merge -d #{@root_path}/app/css/ -r -f #{@root_path}/temp/css/app.css -o #{@root_path}/app/css/#{OUTPUT_MIN_CSS}")
    end

    def merge_js
      p "Merge Js"
      File.open("#{@root_path}/temp/js/app.js","w") do |f|
        # merge const js first
        Dir["#{@root_path}/temp/js/consts/**/*.js"].each do |src_file|
          f.write(File.read(src_file))
        end
        Dir["#{@root_path}/temp/js/app/**/*.js"].each do |src_file|
          f.write(File.read(src_file))
        end
      end
      system("juicer merge -f -s #{@root_path}/temp/js/app.js -o #{@root_path}/app/js/#{OUTPUT_MIN_JS}")
      # for js debug
      system("cp #{@root_path}/temp/js/app.js #{@root_path}/app/js/app.js")
    end
  end
end

guard 'merge-css-js-guard' do
  watch(%r{temp/css/.*\.css$})
  watch(%r{temp/js/app/.*\.js$})
  watch(%r{temp/js/consts/.*\.js$})
end

module ::Guard
  class RenderConstJsGuard < ::Guard::Plugin

    def initialize(options = {})
      @root_path = Pathname.new(File.dirname(__FILE__))
      super
    end

    def run_all
      render_const_js
    end

    def run_on_changes(paths)
      render_const_js(paths)
    end

    def run_on_modifications(paths)
      render_const_js(paths)
    end

    def run_on_addititions(paths)
      render_const_js(paths)
    end

    private

    def render_const_js(paths = [])
      p "Some posts are modified."
      p paths
    end
  end
end

guard 'render-const-js-guard' do
  watch(%r{app/posts/.*\.html$})
end
