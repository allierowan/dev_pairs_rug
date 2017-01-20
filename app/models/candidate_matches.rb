class CandidateMatches
  def self.all_matches
    juniors = Candidate.where(experience: "Junior").to_a
    mids = Candidate.where(experience: "Mid").to_a
    seniors = Candidate.where(experience: "Senior").to_a

    matches = []

    until juniors.empty? || mids.empty?
      matches << [juniors.pop, mids.pop]
    end

    until mids.empty? || seniors.empty?
      matches << [mids.pop, seniors.pop]
    end

    until juniors.empty? || seniors.empty?
      matches << [juniors.pop, seniors.pop]
    end

    [juniors, mids, seniors].each do |collection|
      until collection.empty?
        matches << [collection.pop, collection.pop]
      end
    end

    matches.each do |match|
      if match.one?
        singleton = match.first
        matches.delete(match)
        matches.compact!
        matches.find { |other_match| other_match.size == 2 } << singleton
      end
    end

    matches
  end
end
