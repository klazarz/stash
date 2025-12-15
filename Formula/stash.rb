class Stash < Formula
  desc "Bidirectionally sync Markdown files with Apple Notes"
  homepage "https://github.com/shakedlokits/stash"
  url "https://github.com/shakedlokits/stash/releases/download/v0.1.1/stash"
  sha256 "b5abdfc41a8672f4f8fd9631b50f4efb3e823b043e279f623a9b577b2e49cad7"
  license "GPL-3.0-or-later"

  depends_on "pandoc"
  depends_on "pcre"
  depends_on :macos

  def install
    bin.install "stash"
  end

  test do
    assert_match "stash", shell_output("#{bin}/stash --help")
  end
end
