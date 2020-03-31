require_relative 'ghetto_notes/main'
require_relative 'ghetto_notes/notes_directory'
require_relative 'ghetto_notes/installer'

module GhettoNotes
  USAGE = <<~EOS
    Usage: notes.rb <command>

    One of the following commands must be specified

        install    Install the cronjob to invoke ghetto notes
        sync       Sync notes to remote - pull, commit then push
  EOS

  def self.exit_with_usage
    $stderr.puts(USAGE)
    exit(1)
  end

  def self.bin_file
    path = File.join(File.dirname(__FILE__), '..', 'bin', 'ghetto_notes.rb')
    File.expand_path(path)
  end
end
