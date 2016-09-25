require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "name" do
    let(:rating) { 5.0 }

    it "should not be nil" do
      expect {
        Movie.create!(:rating => rating)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not be blank" do
      expect {
        Movie.create!(:name => '', :rating => rating)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "ratings" do
    let(:movie_name) { 'It\'s a Wonderful Life' }
    let(:rating) { 5.0 }

    it "can be a valid decimal" do
      expect {
        Movie.create!(:name => movie_name, :rating => rating)
      }.not_to raise_error
    end

    it "should not be greater than 10" do
      expect {
        Movie.create!(:name => movie_name, :rating => 10.1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not be less than 0" do
      expect {
        Movie.create!(:name => movie_name, :rating => -0.1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "from Paramount" do
    let(:movies_paramount) do
      movies = [
        {:name => 'Star Trek', :rating => 8.0},
        {:name => 'The Wolf of Wall Street', :rating => 9.2}
      ]
      movies.map { |m| Movie.new(m) }
    end

    before :each do
      allow(Movie).to receive(:from_paramount) { movies_paramount }
    end

    it "should return a valid list of movies" do
      movies = Movie.from_paramount
      movies.each do |movie|
        expect(movie).to be_a(Movie)
      end
    end
  end
end
