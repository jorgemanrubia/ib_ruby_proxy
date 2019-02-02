require 'spec_helper'

describe IbRubyProxy::Util::StringUtils do
  include IbRubyProxy::Util::StringUtils

  describe '#underscore' do
    it 'should convert camel case strings to underscore' do
      expect(to_underscore('heyThere')).to eq('hey_there')
    end
  end

  describe '#to_camel_case' do
    it 'should convert underscore string to camel case' do
      expect(to_camel_case('hey_there')).to eq('heyThere')
    end
  end
end
