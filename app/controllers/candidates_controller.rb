class CandidatesController < ApplicationController
  def index
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :experience)
  end
end
