class EliminarVacunas < ActiveRecord::Migration[6.1]
  def change
    drop_table :vaccines
  end
end
