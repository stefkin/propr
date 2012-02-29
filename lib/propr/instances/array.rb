class Array
  def random(options = {}, m = Propr::Random)
    options = {center: 0}
      .merge(options)
      .merge(min: 0, max: size - 1)

    # @todo: Probably shouldn't scale/skew selection here, as
    # this causes problems with String.random: at small scale
    # we get short strings with only one part of the alphabet
    m.bind(Integer.random(options)) do |index|
      m.unit(self[index])
    end
  end

  def shrink
    return [] if empty?

    combination(size - 1).to_a.tap do |shrunken|
      shrunken << []
      size.times do |n|
        head = self[0, n]
        tail = self[n+1..-1]
        item = self[n]
        shrunken.concat(item.shrink.map{|m| head + [m] + tail })
      end
    end
  end
end

class << Array
  def random(options = {}, m = Propr::Random)
    min  = options[:min] || 0
    max  = options[:max] || 10

    m.bind(Integer.random(min: min, max: max, center: min)) do |size|
      m.sequence(size.times.map { yield })
    end
  end
end