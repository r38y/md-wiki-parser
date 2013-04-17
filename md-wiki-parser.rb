#!/usr/bin/env ruby

require 'redcarpet'

def md(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
  html = markdown.render(text)
  html.gsub!(/^[\w\<][^\n]*\n+/) do |x|
    x =~ /\n{2}/ ? x : (x.strip!; x << "  \n")
  end
end

text = File.read('example.md')

# TODO: Cut file into sections where key is section number and value is text

html = md(text)

File.open('example.html', 'w') {|f| f.write(html) }

