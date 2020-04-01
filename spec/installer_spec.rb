require 'tmpdir'

RSpec.describe GhettoNotes::Installer do
  it 'appends the new cron job' do
    sync_dir = Dir.mktmpdir

    existing_crontab = <<~EOS
      # some bollocks
      * * * * * do_something.sh
    EOS
    crontab = spy(GhettoNotes::Crontab, current: existing_crontab)

    expected_new_crontab = <<~EOS
      # some bollocks
      * * * * * do_something.sh
      */2 * * * * #{GhettoNotes.bin_file} sync #{sync_dir}
    EOS

    expect(crontab).to receive(:set_from) do |fname|
      expect(File.read(fname)).to eq(expected_new_crontab)
    end

    described_class.new(sync_dir, crontab: crontab).perform
  end

  it 'does nothing when the cron job is already there' do
    sync_dir = Dir.mktmpdir
    existing_crontab = <<~EOS
      # some bollocks
      * * * * * do_something.sh
      */2 * * * * #{GhettoNotes.bin_file} sync #{sync_dir}
    EOS
    crontab = spy(GhettoNotes::Crontab, current: existing_crontab)

    expect(crontab).to_not receive(:set_from)

    described_class.new(sync_dir, crontab: crontab).perform
  end
end
