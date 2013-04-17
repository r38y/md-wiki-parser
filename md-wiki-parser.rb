#!/usr/bin/env ruby

require 'redcarpet'

# module Redcarpet
#   module Render
#     class Randy < Base
#       def header()
#     end
#   end
# end

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
  output.join("\n")
end

text = File.read('example.md')

heading_regexp = /^(#+\s.+)/
headings = text.scan(heading_regexp).flatten
puts headings.inject({}) {|h, i| h[headings.index(i)+1] = i; h}

# TODO: find headings and give them a section number
# TODO: find sections by taking section number heading then content until same heading level

# TODO: Cut file into sections where key is section number and value is text

html = md(text)

output_file = File.join(File.dirname(File.expand_path(__FILE__)), 'example.html')
File.open(output_file, 'w') {|f| f.write(html) }
