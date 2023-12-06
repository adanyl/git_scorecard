require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it 'has many contributor_ratings' do
      association = described_class.reflect_on_association(:contributor_ratings)
      expect(association.macro).to eq :has_many
    end

    it 'has many contributors' do
      association = described_class.reflect_on_association(:contributors)
      expect(association.macro).to eq :has_many
    end
  end

  describe '#create_or_update' do
    context 'when rating is new' do
      it 'creates a new rating' do
        expect do
          Rating.create_or_update(Date.yesterday, Date.tomorrow, [])
        end.to change { Rating.count }.by(1)
      end
    end

    context 'when rating already exists' do
      let(:existing_rating) { create(:rating, start_date: Date.yesterday, end_date: Date.tomorrow) }

      it 'updates existing rating and deletes contributor_ratings' do
        expect do
          Rating.create_or_update(Date.yesterday, Date.tomorrow, [])
        end.not_to(change { existing_rating.contributor_ratings.count })
      end
    end
  end

  describe '#update_scores' do
    let(:rating) { create(:rating) }

    it 'updates scores based on events' do
      events = [
        { 'actor' => { 'login' => 'user1' }, 'type' => 'PullRequestEvent' },
        { 'actor' => { 'login' => 'user2' }, 'type' => 'PullRequestReviewCommentEvent' },
        { 'actor' => { 'login' => 'user3' }, 'type' => 'UnknownEventType' }
      ]

      expect do
        rating.update_scores(events)
      end.to change { ContributorRating.sum(:score) }.from(0).to(13)
    end
  end

  describe '#update_score' do
    let(:rating) { create(:rating) }
    let(:contributor) { create(:contributor, username: 'user1') }

    it 'updates contributor rating score based on event type' do
      expect do
        rating.update_score('user1', 'PullRequestEvent')
      end.to change { contributor.contributor_ratings.sum(:score) }.from(0).to(12)
    end
  end
end
