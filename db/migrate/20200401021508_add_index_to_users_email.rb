class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
    #usersテーブルのemailカラムにインデックスuniqueを追加
  end
end
