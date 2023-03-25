require "appraisal/bundler_dsl"

module Appraisal
  autoload :Gemspec, "appraisal/gemspec"
  autoload :Git, "appraisal/git"
  autoload :Group, "appraisal/group"
  autoload :Path, "appraisal/path"
  autoload :Platform, "appraisal/platform"
  autoload :Source, "appraisal/source"
  autoload :Conditional, "appraisal/conditional"

  # Load bundler Gemfiles and merge dependencies
  class Gemfile < BundlerDSL
    def initialize(
      sources: [],
      ruby_version: nil,
      dependencies: DependencyList.new,
      gemspecs: [],
      groups: {},
      platforms: {},
      gits: {},
      paths: {},
      source_blocks: {},
      git_sources: {},
      install_if: {}
    )
      @sources = sources
      @ruby_version = ruby_version
      @dependencies = dependencies
      @gemspecs = gemspecs
      @groups = groups
      @platforms = platforms
      @gits = gits
      @paths = paths
      @source_blocks = source_blocks
      @git_sources = git_sources
      @install_if = install_if
    end

    def load(path)
      run(IO.read(path), path) if File.exist?(path)
    end

    def run(definitions, path, line = 1)
      instance_eval(definitions, path, line) if definitions
    end

    def dup
      self.class.new(
        sources: @sources.dup,
        ruby_version: @ruby_version,
        dependencies: @dependencies,
        gemspecs: @gemspecs.dup,
        groups: @groups.dup,
        platforms: @platforms.dup,
        gits: @gits.dup,
        paths: @paths.dup,
        source_blocks: @source_blocks.dup,
        git_sources: @git_sources.dup,
        install_if: @install_if.dup
      )
    end
  end
end
