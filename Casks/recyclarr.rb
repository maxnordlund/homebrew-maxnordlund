cask "recyclarr" do
  arch arm: "arm64", intel: "x64"

  version "7.4.1"
  sha256 arm:   "3c6ebac0400614748479c3cf9861c6dbf1d6c9d7cb559b2f086a46ee53864b45",
         intel: "2b0a3ea292a77a62a8029347fa0495a7823d8a6d2bd1ab65a0a418b9cd8e06e1"

  url "https://github.com/recyclarr/recyclarr/releases/download/v#{version}/recyclarr-osx-#{arch}.tar.xz",
      verified: "github.com/recyclarr/recyclarr/"
  name "recyclarr"
  desc "Automatically sync TRaSH Guides to your Sonarr and Radarr instances"
  homepage "https://recyclarr.dev/"

  # license "MIT"

  livecheck do
    url :url
  end

  # https://learn.microsoft.com/en-us/dotnet/core/install/macos#supported-versions
  depends_on macos: ">= :ventura"
  depends_on formula: "xz"
  depends_on formula: "wget"

  binary "recyclarr"

  postflight do
    recyclarr = @cask.artifacts.find do |artifact|
      artifact.is_a? Artifact::Binary
    end

    ohai "Syncing config templates and trash guides repositories"
    system_command recyclarr.target,
                   args: ["config", "list", "templates"]
  end

  caveats "To start, run `recyclarr config create`"

  zap trash: "~/Library/Application Support/recyclarr"
end
