require 'fee'

class Bike
  def initialize(user:)
    @user = user
    @begin = nil
    @end = nil
    @fee = Fee.new(role: user.role)
  end

  def rent(time = Time.now)
    @begin = time
  end

  def return(time = Time.now)
    @end = time
  end

  def fee
    # 轉成hour
    period = (@end.to_i - @begin.to_i).to_f / 60 / 60
    @fee.calc(period)
  end
end