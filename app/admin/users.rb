# frozen_string_literal: true

ActiveAdmin.register User do # rubocop:disable Metrics/BlockLength
  before_create do |user|
    user.confirm if user.admin?
  end

  permit_params :first_name, :last_name, :email, :phone_number, :role, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :phone_number
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :role

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone_number
      f.input :role, as: :select
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
