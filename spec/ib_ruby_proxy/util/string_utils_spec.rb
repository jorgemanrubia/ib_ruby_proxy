require 'spec_helper'

describe IbRubyProxy::Util::StringUtils do
  include IbRubyProxy::Util::StringUtils

  describe '#underscore' do
    it 'should convert camel case strings to underscore' do
      expect(to_underscore('heyThere')).to eq('hey_there')
    end
  end
end
