require 'spec_helper'

describe IbRubyProxy::Util::StringUtils do
  include described_class

  describe '#underscore' do
    it 'converts camel case strings to underscore' do
      expect(to_underscore('heyThere')).to eq('hey_there')
    end
  end

  describe '#to_camel_case' do
    it 'converts underscore string to camel case' do
      expect(to_camel_case('hey_there')).to eq('heyThere')
    end
  end
end
