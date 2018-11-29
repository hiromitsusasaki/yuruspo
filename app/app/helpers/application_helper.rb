module ApplicationHelper

  def content_icon(content_id)
    case content_id
    when 0
      svg_file_name = "icon_basketball.svg"
    when 1
      svg_file_name = "icon_soccer.svg"
    when 2
      svg_file_name = "icon_volleyball.svg"
    when 3
      svg_file_name = "icon_baseball.svg"
    when 4
      svg_file_name = "icon_tennis.svg"
    when 5
      svg_file_name = "icon_badminton.svg"
    end
    embedded_svg(svg_file_name,  {class: "icon_content"})
  end

  def embedded_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

end
