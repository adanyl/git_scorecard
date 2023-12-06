require 'rails_helper'

RSpec.describe ContributorRating, type: :model do
  describe 'associations' do
    it 'belongs to rating' do
      association = described_class.reflect_on_association(:rating)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to contributor' do
      association = described_class.reflect_on_association(:contributor)
      expect(association.macro).to eq :belongs_to
    end
  end
end
