# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'validations' do
    subject { build(:course) }

    # Uniqueness
    it do
      is_expected.to validate_uniqueness_of(:repo_id)
        .case_insensitive
    end
    it do
      is_expected.to validate_uniqueness_of(:repo_name)
        .case_insensitive
        .scoped_to(:user_id)
    end

    # Required fields
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:repo_id) }
    it { is_expected.to validate_presence_of(:repo_name) }
    it { is_expected.to validate_presence_of(:repo_url) }

    # Belongs to
    it { is_expected.to belong_to(:user) }
  end
  describe '#to_param' do
    it 'returns `repo_name` field as parameter' do
      course = build(:course)
      expect(course.to_param).to eq(course.repo_name)
    end
  end
end
