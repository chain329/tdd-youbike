require 'fee'

RSpec.describe Fee do
  subject { described_class.new(role: role).calc(period) }

  describe '非會員 - 租車費用' do
    let(:role) { 'user' }

    context '4 小時內，費率為每 30 分鐘 10 元' do
      let(:period) { 4 }
      let(:fee) { 10 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end

    context '超過 4 小時，但於 8 小時內還車，第 4~8 小時費率為每 30 分鐘 20 元' do
      let(:period) { 8 }
      let(:fee) { 10 * 2 * 4 + 20 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end

    context '超過 8 小時，於第 8 小時起將以每 30 分鐘 40 元計價' do
      let(:period) { 12 }
      let(:fee) { 10 * 2 * 4 + 20 * 2 * 4 + 40 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end
  end

  describe '會員 - 租車費用' do
    let(:role) { 'member' }

    context '前 30 分鐘 5 元' do
      let(:period) { 0.5 }
      let(:fee) { 5 }

      it { is_expected.to eq(fee) }
    end

    context '超過 30 分鐘，但於 4 小時內還車，費率為每 30 分鐘 10 元。' do
      let(:period) { 4 }
      let(:fee) { 5 + 10 * 2 * 3.5 }

      it { is_expected.to eq(fee) }
    end

    context '超過 4 小時，但於 8 小時內還車，第 4~8 小時費率為每 30 分鐘 20 元' do
      let(:period) { 8 }
      let(:fee) { 5 + 10 * 2 * 3.5 + 20 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end

    context '超過 8 小時，於第 8 小時起將以每 30 分鐘 40 元計價' do
      let(:period) { 12 }
      let(:fee) { 5 + 10 * 2 * 3.5 + 20 * 2 * 4 + 40 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end
  end

  describe '未知的角色' do
    let(:role) { 'undefined' }

    it { expect { subject }.to raise_error(Fee::NotFound) }
  end
end
