RSpec.describe GhettoNotes::NotesDirectory do
  before do
    @master_repo = Repo.create

    @remote_repo =
      Repo.clone_from(@master_repo)
        .set_file_content('foo.md', 'initial notes')
        .commit
        .push

    @local_repo = Repo.clone_from(@master_repo)
  end

  it 'gets changes from the remote repo' do
    @remote_repo
      .set_file_content('foo.md', 'updated notes')
      .commit
      .push

    notes_dir = GhettoNotes::NotesDirectory.new(@local_repo.repo_dir)

    expect { notes_dir.sync }
      .to change { File.read(File.join(@local_repo.repo_dir, 'foo.md')) }
      .from(/initial notes/)
      .to(/updated notes/)
  end

  it 'sends changes to the remote repo' do
    @local_repo
      .set_file_content('foo.md', 'updated notes')
      .commit
      .push

    notes_dir = GhettoNotes::NotesDirectory.new(@local_repo.repo_dir)
    notes_dir.sync

    expect { @remote_repo.pull }
      .to change { File.read(File.join(@remote_repo.repo_dir, 'foo.md')) }
      .from(/initial notes/)
      .to(/updated notes/)
  end
end
