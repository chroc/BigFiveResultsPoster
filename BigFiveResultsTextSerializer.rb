# Sergio Rojas
# 19052017

class BigFiveResultsTextSerializer

  attr_accessor :text

  def initialize (text)
    @text = text
  end

  def hash_function
    topics = Array.new
    facets = Array.new

    results = Hash.new
    topics_hash = Hash.new
    results["NAME"] = "Sergio Rojas"
    results["EMAIL"] = ""

    @text.each do |line|
      topic = ""
      facet = ""
      value = ""

      if line[0..1] != ".."

        # topic
        for i in 0..line.length
          char = line[i...i+1]
          if !is_number?(char) and char != "."
            topic += char
          elsif is_number?(char) and char != "."
            value += char
          end
        end
        topics.push(topic)
        topics.push(value)

      else

        # facet
        for i in 0..line.length
          char = line[i...i+1]
          if !is_number?(char) and char != "."
            facet += char
          elsif is_number?(char) and char != "."
            value += char
          end
        end
        facets.push(facet)
        facets.push(value)

      end
    end

    position = 0
    topics_pos = 0

    for j in 0..4
      facets_hash = Hash.new
      topics_hash = Hash.new

      for i in 0..5
        # build facets hash
        facets_hash[facets[position]] = facets[position + 1]
        position += 2
      end

      topics_hash["Overall Score"] = topics[topics_pos + 1]
      topics_hash["Facets"] = facets_hash

      # build results hash
      results[topics[topics_pos]] = topics_hash
      topics_pos += 2
      # binding.pry

    end
    results
  end

  # from stackoverflow
  # http://stackoverflow.com/questions/8616360/how-to-check-if-a-variable-is-a-number-or-a-string
  def is_number? number
    number.to_f.to_s == number.to_s || number.to_i.to_s == number.to_s
  end

end
