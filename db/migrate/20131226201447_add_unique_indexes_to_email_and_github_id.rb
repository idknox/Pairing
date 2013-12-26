class AddUniqueIndexesToEmailAndGithubId < ActiveRecord::Migration
  def change
    execute <<-SQL
      CREATE INDEX index_users_email ON users ((lower(email)));
    SQL
    execute <<-SQL
      CREATE INDEX index_users_github_id ON users ((lower(github_id)));
    SQL
  end
end
