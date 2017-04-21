module TracksHelper
  include ERB::Util

  def ugly_lyrics(lyrics)
    lines = lyrics.split("\n")
    lines.map do |line|
      ("&#9835 " + h(line)).html_safe
    end
  end
end
