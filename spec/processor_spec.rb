require 'spec_helper'

describe SignatureGenerator::Processor do

  let(:signature_templates) do
    st = {}
    template_dir = File.expand_path '../../test/templates', __FILE__
    Dir.glob("#{template_dir}/*.html.erb", File::FNM_DOTMATCH).each do |file|
      file.match /\/(?<id>[^\/]+)\.html\.erb/ do |md|
        id = md['id'].to_sym
        st[id] = File.read file
      end
    end
    st
  end

  subject { described_class.new }

  it 'should transform templates into signatures using ERB' do
    expect(subject.transform signature_templates[:sig1]).to eq 'ERB rulez'
  end





end