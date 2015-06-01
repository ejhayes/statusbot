class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, :null => false
      t.string :description, :null => false
      t.datetime :last_started, :null => false
      t.integer :elapsed_minutes, :null => false, :default => 0
      t.integer :status, :null => false, :default => 0
      t.datetime :closed_at

      t.timestamps
    end

    create_table :blockers do |t|
      t.references :user, :null => false
      t.string :description, :null => false

      t.timestamps
    end

    create_table :pings do |t|
      t.references :blocker, :null => false
      t.references :activity, :null => false

      t.timestamps
    end

    create_table :week_goals do |t|
      t.references :user, :null => false
      t.string :description, :null => false
      t.integer :status, :null => false, :default => 0
      t.datetime :goal_date, :null => false
      t.datetime :closed_at

      t.timestamps
    end

    create_table :daily_goals do |t|
      t.references :user, :null => false
      t.string :description, :null => false
      t.integer :status, :null => false, :default => 0
      t.datetime :goal_date, :null => false
      t.datetime :closed_at

      t.timestamps
    end
  end
end
