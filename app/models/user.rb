# frozen_string_literal: true

class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:github]
  has_many :courses, dependent: :destroy

  # Required fields
  validates :login, presence: true, uniqueness: { case_sensitive: false }
  validates :avatar_url, presence: true
  validates :github_id, presence: true, uniqueness: true
  validates :github_token, presence: true
  validates :github_url, presence: true

  def self.find_or_create_by(payload)
    attrs = extract_from(payload)

    # Let's see if we can find an existing user
    user = User.find_by_github_id(attrs[:github_id])

    # Either we have a new user
    if user.nil?
      user = User.create!(attrs)

    # Or we should update our existing user's attributes
    else
      user.update_attributes(attrs)
    end

    user
  end

  # rubocop:disable Metrics/AbcSize
  def self.extract_from(payload)
    {
      name:         payload[:info][:name],
      email:        payload[:info][:email],
      login:        payload[:info][:nickname],
      avatar_url:   payload[:info][:image],
      github_id:    payload[:uid].to_i,
      github_token: payload[:credentials][:token],
      github_url:   payload[:extra][:raw_info][:html_url],
      location:     payload[:extra][:raw_info][:location]
    }
  end

  def to_param
    # We use `login` as an identifier in `user#show` and `user#destroy` routes
    login
  end
end
