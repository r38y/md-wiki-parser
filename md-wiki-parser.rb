#!/usr/bin/env ruby

require 'redcarpet'

def md(text)
  toc_renderer = Redcarpet::Render::HTML_TOC.new

  html_renderer = Redcarpet::Render::HTML.new(
    hard_wrap: true,
    with_toc_data: true,
  )
  toc_markdown = Redcarpet::Markdown.new(toc_renderer,
    autolink: true,
    space_after_headers: true,
  )
  html_markdown = Redcarpet::Markdown.new(html_renderer,
    autolink: true,
    space_after_headers: true,
  )
  output = []
  output << toc_markdown.render(text)
  output << html_markdown.render(text)
  output.join('')
end

text = File.read('example.md')

# TODO: Cut file into sections where key is section number and value is text

html = md(text)

output_file = File.join(File.dirname(File.expand_path(__FILE__)), 'example.html')
File.open(output_file, 'w') {|f| f.write(html) }

