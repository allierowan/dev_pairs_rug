require "spec_helper"

RSpec.describe CandidateMatches do
  before do
    Candidate.delete_all
  end

  describe ".all_matches" do
    context "with an even number of people all with the same skill level" do
      it "returns an array of two-candidate arrays, each candidate appearing once" do
        candidate_1 = Candidate.create!(name: "One", experience: "Junior")
        candidate_2 = Candidate.create!(name: "Two", experience: "Junior")
        candidate_3 = Candidate.create!(name: "Three", experience: "Junior")
        candidate_4 = Candidate.create!(name: "Four", experience: "Junior")

        results = CandidateMatches.all_matches

        expect(results.count).to eq(2)
        expect(results.first.count).to eq(2)
        expect(results.last.count).to eq(2)
        expect(results.flatten).
          to match_array([candidate_1, candidate_2, candidate_3, candidate_4])
      end
    end

    context "with an odd number of people all with the same skill level" do
      it "adds the odd-person-out into one of the pairs" do
        candidate_1 = Candidate.create!(name: "One", experience: "Junior")
        candidate_2 = Candidate.create!(name: "Two", experience: "Junior")
        candidate_3 = Candidate.create!(name: "Three", experience: "Junior")
        candidate_4 = Candidate.create!(name: "Four", experience: "Junior")
        candidate_5 = Candidate.create!(name: "Five", experience: "Junior")

        results = CandidateMatches.all_matches

        expect(results.count).to eq(2)
        expect(results.flatten).
          to match_array([candidate_1, candidate_2, candidate_3, candidate_4, candidate_5])
      end
    end

    context "with an even number of people ideal skill level breakdown" do
      it "pairs jrs and srs with mids" do
        candidate_1 = Candidate.create!(name: "One", experience: "Mid")
        candidate_2 = Candidate.create!(name: "Two", experience: "Mid")
        candidate_3 = Candidate.create!(name: "Three", experience: "Senior")
        candidate_4 = Candidate.create!(name: "Four", experience: "Junior")

        results = CandidateMatches.all_matches

        expect(results.count).to eq(2)
        expect(results.flatten).
          to match_array([candidate_1, candidate_2, candidate_3, candidate_4])
        experiences = [results.first.map(&:experience), results.last.map(&:experience)]
        expect(experiences).to include(a_collection_including("Junior", "Mid"))
        expect(experiences).to include(a_collection_including("Mid", "Senior"))
      end
    end

  end
end
