describe 'Matrix' do

  before do
    class << self
      include CDQ
    end
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a Matrix entity' do
    Matrix.entity_description.name.should == 'Matrix'
  end
end
