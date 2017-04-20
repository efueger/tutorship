class RenameRepoSlugToRepoNameInCourses < ActiveRecord::Migration[5.1]
  def change
    rename_column :courses, :repo_slug, :repo_name
  end
end
