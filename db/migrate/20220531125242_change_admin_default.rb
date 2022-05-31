class ChangeAdminDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :admin, to: false
  end
end
