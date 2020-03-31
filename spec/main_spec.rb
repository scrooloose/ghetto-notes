RSpec.describe GhettoNotes::Main do
  it 'handles the sync command' do
    expect(GhettoNotes::NotesDirectory)
      .to receive(:new)
      .and_return(double(GhettoNotes::NotesDirectory, sync: true))

    described_class.new('sync', '/tmp/path/to/notes').run
  end

  it 'handles the install command' do
    expect(GhettoNotes::Installer)
      .to receive(:new)
      .and_return(double(GhettoNotes::Installer, perform: true))

    described_class.new('install', '/tmp/path/to/notes').run
  end

  it 'exits if an unknown subcommand is passed in' do
    expect(GhettoNotes)
      .to receive(:exit_with_usage)

    described_class.new('unknown_command', '/tmp/path/to/notes')
  end
end
