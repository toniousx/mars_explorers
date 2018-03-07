# 'spec_helper' *invoked in ~\.rspec
require 'mars_rovers'

describe MarsRovers do
  describe 'Input' do
    it 'has only integers' do
      expect(described_class.input).to be_a(Integer)
    end
  end
end
