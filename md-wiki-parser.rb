#!/usr/bin/env ruby

require 'redcarpet'

def md_toc(text)
  renderer = Redcarpet::Render::HTML_TOC.new
  markdown = Redcarpet::Markdown.new(renderer,
    space_after_headers: true,
  )
  markdown.render(text)
end

def md_html(text)
  renderer = Redcarpet::Render::HTML.new(
    hard_wrap: true,
    with_toc_data: true,
  )
  markdown = Redcarpet::Markdown.new(renderer,
    autolink: true,
    space_after_headers: true,
  )
  markdown.render(text)
end

def md(text)
  output = []
  output << md_toc(text)
  output << md_html(text)
  output.join('')
end

text = File.read('example.md')

# TODO: Cut file into sections where key is section number and value is text

html = md(text)

output_file = File.join(File.dirname(File.expand_path(__FILE__)), 'example.html')
File.open(output_file, 'w') {|f| f.write(html) }

