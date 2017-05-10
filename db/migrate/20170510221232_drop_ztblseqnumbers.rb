class DropZtblseqnumbers < ActiveRecord::Migration[5.0]
  def change
    drop_table :ztblseqnumbers
  end
end
