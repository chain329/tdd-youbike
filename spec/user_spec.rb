require 'user'

RSpec.describe User do
  describe '#role' do
    subject { user.role }

    context '未設定會員' do
      let!(:user) { User.new }

      it { is_expected.to eq('user')}
    end

    context '有設定會員' do
      let!(:user) { User.new(role: 'member') }

      it { is_expected.to eq('member') }
    end
  end
end
