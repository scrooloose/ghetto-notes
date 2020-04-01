require 'tempfile'

module GhettoNotes
  class Installer
    attr_reader :sync_dir, :crontab

    def initialize(sync_dir, crontab: Crontab.new)
      @sync_dir = sync_dir
      @crontab = crontab
    end

    def perform
      cmd = "#{GhettoNotes.bin_file} sync #{sync_dir}"
      crontab_entry = "*/2 * * * * #{cmd}"
      existing_tab = crontab.current.split("\n")

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

      crontab.set_from(new_crontab.path)
    end
  end

  class Crontab
    def current
      `crontab -l`
    end

    def set_from(fname)
      `crontab #{new_crontab.path}`
    end
  end
end
