# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    subject { build(:user) }

    # Uniqueness
    it do
      is_expected.to validate_uniqueness_of(:login)
        .case_insensitive
    end
    it do
      is_expected.to validate_uniqueness_of(:github_id)
    end

    # Required fields
    it { is_expected.to validate_presence_of(:login) }
    it { is_expected.to validate_presence_of(:github_id) }
    it { is_expected.to validate_presence_of(:github_token) }
    it { is_expected.to validate_presence_of(:github_url) }
    it { is_expected.to validate_presence_of(:avatar_url) }

    # Has many courses
    it { is_expected.to have_many(:courses) }
  end

  describe '.find_or_create_by' do
    it 'creates a new record if it doesn\'t exist' do
      user = User.find_or_create_by(fake_github)
      expect(user.persisted?).to eq(true)
    end
    it 'returns an existing record details if any' do
      existing_user = create(:user)
      payload = fake_github
      payload[:uid] = existing_user.github_id
      user = User.find_or_create_by(payload)
      expect(existing_user).to eq(user)
    end
  end

  describe '.extract_from' do
    let(:payload) do
      # TODO: replace fake_github call with:
      #   Faker::Omniauth.github
      # Refer to fake_github function above for more info
      fake_github
    end

    let(:result) do
      User.extract_from(payload)
    end

    it 'returns valid `name`' do
      expect(result[:name]).to eq(payload[:info][:name])
    end
    it 'returns valid `email`' do
      expect(result[:email]).to eq(payload[:info][:email])
    end
    it 'returns valid `login`' do
      expect(result[:login]).to eq(payload[:info][:nickname])
    end
    it 'returns `github_id` as instance of Integer' do
      expect(result[:github_id]).to be_instance_of(Integer)
    end
    it 'returns `uid` as github_id`' do
      expect(result[:github_id]).to eq(payload[:uid].to_i)
    end
    it 'returns valid `github_token`' do
      expect(result[:github_token]).to eq(payload[:credentials][:token])
    end
    it 'returns valid `github_url`' do
      expect(result[:github_url]).to eq(payload[:info][:urls][:GitHub])
    end
    it 'returns valid `location`' do
      expect(result[:location]).to eq(payload[:extra][:raw_info][:location])
    end
    it 'returns valid `avatar_url`' do
      expect(result[:avatar_url]).to eq(payload[:info][:image])
    end
  end

  describe '#to_param' do
    it 'returns `login` field as parameter' do
      user = build(:user)
      expect(user.to_param).to eq(user.login)
    end
  end
end
