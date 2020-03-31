require 'tempfile'

module GhettoNotes
  class Installer
    attr_reader :sync_dir

    def initialize(sync_dir)
      @sync_dir = sync_dir
    end

    def perform
      cmd = "#{GhettoNotes.bin_file} sync #{sync_dir}"
      crontab_entry = "*/2 * * * * #{cmd}"
      existing_tab = `crontab -l`.split("\n")

      if existing_tab.include?(crontab_entry)
        $stderr.puts 'Already installed'
        return
      end

      new_crontab = Tempfile.new
      new_crontab << existing_tab.join("\n")
      new_crontab << "\n"
      new_crontab << crontab_entry
      new_crontab << "\n"
      new_crontab.close

      `crontab #{new_crontab.path}`
    end
  end
end
