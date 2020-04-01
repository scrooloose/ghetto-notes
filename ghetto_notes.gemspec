
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ghetto_notes/version"

Gem::Specification.new do |spec|
  spec.name          = "ghetto_notes"
  spec.version       = GhettoNotes::VERSION
  spec.authors       = ["Martin Grenfell"]
  spec.email         = ["martin.grenfell@gmail.com"]

  spec.summary       = %q{Extremely shit note syncing program.}
  spec.description   = %q{Sync a notes dir to and from a remote repo.}
  spec.homepage      = "https://github.com/scrooloose/ghetto-notes"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rspec", "~> 3.9.0"
  spec.add_development_dependency "pry", "~> 0.13.0"
end
