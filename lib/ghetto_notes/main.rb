require 'optparse'

module GhettoNotes
  class Main
    def initialize(subcommand, sync_dir)
      @subcommand = subcommand
      @sync_dir = File.expand_path(sync_dir)
      GhettoNotes.exit_with_usage unless ['install', 'sync'].include?(subcommand)
    end

    def run
      send("#{subcommand}_subcommand")
    end

    private

    attr_reader :subcommand, :sync_dir

    def sync_subcommand
      NotesDirectory.new(sync_dir).sync
    end

    def install_subcommand
      Installer.new(sync_dir).perform
    end
  end
end
