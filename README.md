# SCS (Slim, Coffeescript and SASS) blog generator

## Why?

1. I need a blog to write down my note.
2. Why don't use Jekyll? Jekyll is markup-based blog, but some features are not supported by markup, such as table, image and color-highlight.
3. There are many Jekyll plugins, maybe some of them provide the features you want...  Yes, maybe you are right, but you need to embeded Liquid syntax in the markup file. It is really weired to me. And why not just use standard HTML, CSS and JS? It's more flexible and straight-forward.
4. How about the category or tag features? That is what this framework try to solve.

## What?

SCS Blog Generator is a blog system based on SCS Playground framework. Use HTML and built-in CSS to write the blog.

It's also an AngularJS app, the blog layout is implemented with ng-resource. Moreover, you can write your own angular codes on it.

## How?

### Install

1. Prepare ruby.
2. Prepare your JavaScript runtime, such as node.js.
3. Run "bundle install".
4. Run "juicer install yui_compressor" and "juicer install jslint"

### Write down your posts

1. Run "guard".
2. Run "all" in guard to generate the example post if you want to give it a try.
3. Write your post in src/posts
4. Guard would build the html-format posts in app/posts folder automatically.
5. Open the app/index.html to see your blog

## Folders

    ├── app
    │   ├── css -- where to generate the css files
    │   │   └── app.css
    │   ├── html -- where to generate the static html files
    │   │   └── index.html
    │   ├── images
    │   ├── js -- where to generate the javascript files
    │   │   └── app.js
    │   ├── posts -- where to generate the posts
    │   └── index.html -- the blog home page
    ├── config
    │   └── compass.rb
    ├── Gemfile
    ├── Gemfile.lock
    ├── Guardfile
    ├── LICENSE
    ├── README.md
    └── src
        ├── coffeescript
        │   └── app
        │       └── js -- where to put the coffeescript files
        │           └── app.js.coffee
        ├── sass -- where to put sass files
        │   ├── blog.css.sass -- the built-in style for blog posts.
        │   └── app.css.sass
        └── slim -- where to put static slim files
            └── index.html.slim

## Authors

Sibevin Wang

## Copyright

Copyright (c) 2014 Sibevin Wang. Released under the MIT license.
