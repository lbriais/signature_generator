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

  let(:missing_vars) {signature_templates[:missing_vars]}

  subject { described_class.new }

  it 'should transform templates into signatures using ERB' do
    expect(subject.transform signature_templates[:sig1]).to eq 'ERB rulez'
  end

  context 'when some inputs are missing' do

    it 'should raise a NameError' do
      expect(subject).to receive(:get_user_input).exactly(described_class::MAX_RETRY).times
      expect {subject.transform missing_vars}.to raise_error NameError
    end

    context 'when some correct context is provided' do

      let(:context) { {i_m_a_missing_variable: 'now with content'} }

      subject { described_class.new context}

      it 'should not raise a NameError' do
        expect {subject.transform missing_vars}.not_to raise_error
      end

    end

    context 'when some incorrect context is provided' do

      let(:context) { {useless_variable: 'some content'} }

      subject { described_class.new context}

      it 'should still raise a NameError' do
        expect(subject).to receive(:get_user_input).exactly(described_class::MAX_RETRY).times
        expect {subject.transform missing_vars}.to raise_error NameError
      end

    end

  end


end