class Repo
  attr_reader :repo_dir

  def self.create
    repo_dir = Dir.mktmpdir
    `git init --bare #{repo_dir}`

    new(repo_dir)
  end

  def self.clone_from(repo)
    new_repo_dir = Dir.mktmpdir
    `git clone -q #{repo.repo_dir} #{new_repo_dir}`

    new(new_repo_dir)
  end

  def initialize(repo_dir)
    @repo_dir = repo_dir
  end

  def set_file_content(fname, content)
    File.open(File.join(repo_dir, fname), 'w') do |file|
      file << content + "\n"
    end
    self
  end

  def commit
    git_cmd do
      `git add .`
      `git commit -m 'foo'`
    end
  end

  def push
    git_cmd { `git push` }
  end

  def pull
    git_cmd { `git pull origin master` }
  end

  def git_cmd(&block)
    Dir.chdir(repo_dir)
    $stdout.reopen('/dev/null', 'w')
    yield
    self
  ensure
    $stdout.reopen(STDOUT, 'w')
  end
end

