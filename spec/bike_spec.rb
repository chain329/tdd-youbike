require 'timecop'
require 'user'
require 'bike'

RSpec.describe Bike do
  subject { bike.fee }

  let(:bike) { described_class.new(user) }

  before do
    now = Time.now
    Timecop.freeze(now)
    bike.rent
    Timecop.travel(now + period)
    bike.return
  end

  after do
    Timecop.return
  end

  describe '非會員 - 租車費用' do
    let(:user) { User.new }

    context '4 小時內，費率為每 30 分鐘 10 元' do
      let(:period) { 4 * 60 * 60 }
      let(:fee) { 10 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end

    context '超過 4 小時，但於 8 小時內還車，第 4~8 小時費率為每 30 分鐘 20 元' do
      let(:period) { 8 * 60 * 60 }
      let(:fee) { 10 * 2 * 4 + 20 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end

    context '超過 8 小時，於第 8 小時起將以每 30 分鐘 40 元計價' do
      let(:period) { 12 * 60 * 60 }
      let(:fee) { 10 * 2 * 4 + 20 * 2 * 4 + 40 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end
  end

  describe '會員 - 租車費用' do
    let(:user) { User.new(member: true) }

    context '前 30 分鐘 5 元' do
      let(:period) { 30 * 60 }
      let(:fee) { 5 }

      it { is_expected.to eq(fee) }
    end

    context '超過 30 分鐘，但於 4 小時內還車，費率為每 30 分鐘 10 元。' do
      let(:period) { 4 * 60 * 60 }
      let(:fee) { 5 + 10 * 2 * 3.5 }

      it { is_expected.to eq(fee) }
    end

    context '超過 4 小時，但於 8 小時內還車，第 4~8 小時費率為每 30 分鐘 20 元' do
      let(:period) { 8 * 60 * 60 }
      let(:fee) { 5 + 10 * 2 * 3.5 + 20 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end

    context '超過 8 小時，於第 8 小時起將以每 30 分鐘 40 元計價' do
      let(:period) { 12 * 60 * 60 }
      let(:fee) { 5 + 10 * 2 * 3.5 + 20 * 2 * 4 + 40 * 2 * 4 }

      it { is_expected.to eq(fee) }
    end
  end
end
