require "date"

class << Date
  MIN = Date.jd(1_721_058) # 0000-01-01
  MAX = Date.jd(5_373_484) # 9999-12-31

  def random(options = {}, m = Propr::Random)
    # These would be constants but `jd` is only defined
    # after `require "date"`.
    min = (options[:min] || MIN).jd
    max = (options[:max] || MAX).jd

    m.bind(Integer.random(options.merge(min: min, max: max))) do |n|
      m.unit(jd(n))
    end
  end
end
