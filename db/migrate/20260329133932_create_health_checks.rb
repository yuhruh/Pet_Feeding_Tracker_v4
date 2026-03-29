class CreateHealthChecks < ActiveRecord::Migration[8.0]
  def change
    create_table :health_checks do |t|
      t.decimal :crea
      t.decimal :bun
      t.decimal :phos
      t.decimal :ca
      t.decimal :alb
      t.decimal :chol
      t.decimal :tp
      t.decimal :alt
      t.decimal :alkp
      t.decimal :ggt
      t.decimal :glu
      t.decimal :tbil
      t.decimal :amyl
      t.integer :lipa
      t.decimal :na
      t.decimal :k
      t.decimal :cl
      t.decimal :rbc
      t.decimal :hct
      t.decimal :hgb
      t.decimal :mcv
      t.decimal :mch
      t.decimal :mchc
      t.decimal :rdw
      t.decimal :retic
      t.decimal :retic_hgb
      t.decimal :wbc
      t.decimal :neu
      t.decimal :lym
      t.decimal :mono
      t.decimal :eos
      t.decimal :baso
      t.integer :plt
      t.decimal :mpv
      t.decimal :pct
      t.integer :osm_cal
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
