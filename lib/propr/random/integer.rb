class Integer
  MAX = 2 ** (0.size * 8 - 2) - 1
  MIN = -MAX + 1
end

class << Integer
  def random(options = {}, m = Propr::Random)
    min = (options[:min] || Integer::MIN).to_i
    max = (options[:max] || Integer::MAX).to_i

    raise ArgumentError,
      "min > max" if min > max

    range  = max - min
    center = options.fetch(:center, :mid)
    center =
      case center
      when :mid then min + (max - min).div(2)
      when :min then min
      when :max then max
      when Numeric
        raise ArgumentError,
          "center < min" if center < min
        raise ArgumentError,
          "center > max" if center > max
        center
      else raise ArgumentError,
        "center must be :min, :mid, :max, or min <= Integer <= max"
      end

    m.bind(m.rand(range + 1)) do |rnd|
      m.bind(m.scale(rnd + min, range, BigDecimal(center))) do |n|
        # Round up or down to integer nearest center
        m.unit(n > center ? n.floor : n.ceil)
      end
    end
  end
end
