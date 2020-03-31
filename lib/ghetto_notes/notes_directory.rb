module GhettoNotes
  class NotesDirectory
    attr_reader :dir

    def initialize(dir)
      @dir = dir
    end

    def sync
      Dir.chdir(dir)
      system('git pull origin master')
      system('git add .')
      system('git commit -m "ghetto notes: add latest changes"')
      system('git push')
    end
  end
end
