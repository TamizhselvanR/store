class CreateProducts < ActiveRecord::Migration[8.1]
  # why do we use change here?
  # When we use change if we want to rollback using rails db:migrate
  # it will automatically rollback the changes done in change

  # When can we use up/down?
  # If we are going to have migrations like data manipulation we need it,
  # The most common example is remove_column.
  # If you remove a column, Rails cannot know what data type, options, or name to use to put it back:
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
