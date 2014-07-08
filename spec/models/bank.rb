describe 'Bank' do

  before do
    class << self
      include CDQ
    end
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a Bank entity' do
    Bank.entity_description.name.should == 'Bank'
  end
end
