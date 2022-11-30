class FixColumnNameCoast < ActiveRecord::Migration[5.2]
  def change
    rename_column :states, :coast, :coastal
  end
end
