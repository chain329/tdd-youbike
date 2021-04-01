class Fee
  class NotFound < StandardError; end

  PRICES_TABLE = {
    'user' => {
      4 => 10 * 2,
      8 => 20 * 2,
      Float::INFINITY => 40 * 2
    },
    'member' => {
      0.5 => 5 * 2,
      4 => 10 * 2,
      8 => 20 * 2,
      Float::INFINITY => 40 * 2
    }
  }
  # CALC_METHOD = :calc_price_normal
  CALC_METHOD = :calc_price_recursive

  def initialize(role: 'user')
    raise NotFound unless PRICES_TABLE.keys.include?(role)

    @prices_table = PRICES_TABLE[role]
  end

  def calc(period)
    send(CALC_METHOD, @prices_table.dup, period)
  end

  private

    # normal version
    def calc_price_normal(prices_table, period)
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
      total.to_i
    end

    # recursive version
    def calc_price_recursive(prices_table, period, total = 0, current = 0)
      point = prices_table.keys.first
      price = prices_table.delete(point)
      if period <= point
        total += (period - current) * price
        return total.to_i
      else
        total += (point - current) * price
        calc_price_recursive(prices_table, period, total, point)
      end
    end
end
