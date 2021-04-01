require 'user'

RSpec.describe User do
  describe '#member?' do
    subject { user.member? }

    context '未設定會員' do
      let!(:user) { User.new }

      it { is_expected.to be false }
    end

    context '有設定會員' do
      let!(:user) { User.new(member: true) }

      it { is_expected.to be true }
    end
  end
end
