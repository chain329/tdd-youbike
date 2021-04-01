class Bike
  PRICES_TABLE = {
    user: {
      4 => 10 * 2,
      8 => 20 * 2,
      Float::INFINITY => 40 * 2
    },
    member: {
      0.5 => 5 * 2,
      4 => 10 * 2,
      8 => 20 * 2,
      Float::INFINITY => 40 * 2
    }
  }

  def initialize(user)
    @user = user
    @begin = nil
    @end = nil
  end

  def rent(time = Time.now)
    @begin = time
  end

  def return(time = Time.now)
    @end = time
  end

  def fee
    type = @user.member? ? :member : :user
    # 轉成hour
    period = (@end.to_i - @begin.to_i).to_f / 60 / 60
    calc_price(PRICES_TABLE[type].dup, period).to_i
  end

  private

    # normal version
    def calc_price(prices_table, period)
      total = 0
      current = 0
      prices_table.each do |point, price|
        if period <= point
          total += (period - current) * price
          break
        else
          total += (point - current) * price
          current = point
        end
      end
      total
    end

    # recursive version
    # def calc_price(prices_table, period, total = 0, current = 0)
    #   point = prices_table.keys.first
    #   price = prices_table.delete(point)
    #   if period <= point
    #     return (total + (period - current) * price)
    #   else
    #     total += (point - current) * price
    #     calc_price(prices_table, period, total, point)
    #   end
    # end
end