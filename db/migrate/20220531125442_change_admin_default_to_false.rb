class ChangeAdminDefaultToFalse < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :admin, from: true, to: false
  end
end
