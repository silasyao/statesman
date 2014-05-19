require "rails/version"
require "ammeter/init"

TMP_GENERATOR_PATH = File.expand_path('../generator-tmp', __FILE__)

shared_examples 'a generator' do
  destination TMP_GENERATOR_PATH
  before { prepare_destination }
  let(:gen) { generator %w[Yummy::Bacon Yummy::BaconTransition] }

  it 'invokes create_model_file method' do
    expect(gen).to receive(:create_model_file)
    capture(:stdout) { gen.invoke_all }
  end

  describe 'it runs the generator and check things out' do

    before { run_generator %w[Yummy::Bacon Yummy::BaconTransition] }

    describe 'it generates a correctly named file' do
      subject { file(migration_name) }
      it { should be_a_migration }
    end

  end

end

RSpec.configure do |config|
  config.after :all do
    FileUtils.rm_rf(TMP_GENERATOR_PATH)
  end
end
