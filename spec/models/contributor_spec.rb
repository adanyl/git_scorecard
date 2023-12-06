require 'rails_helper'

RSpec.describe Contributor, type: :model do
  describe 'associations' do
    it 'has many contributor_ratings' do
      association = described_class.reflect_on_association(:contributor_ratings)
      expect(association.macro).to eq :has_many
    end

    it 'has many ratings' do
      association = described_class.reflect_on_association(:ratings)
      expect(association.macro).to eq :has_many
    end
  end
end
