# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :repo_id, presence: true, uniqueness: true
  validates :repo_name, presence: true, uniqueness: {
    scope: :user_id, case_sensitive: false
  }
  validates :repo_url, presence: true

  def to_param
    repo_name
  end
end
