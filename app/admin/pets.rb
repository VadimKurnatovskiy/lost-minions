# frozen_string_literal: true

ActiveAdmin.register Pet do
  permit_params :name, :age, :breed_id, :user_id, :gender, :description,
                :situation, :address, :latitude, :longitude, pictures: []

  index do
    selectable_column
    id_column
    column :name
    column :age
    column :gender
    column :user
    column :breed
    column :description
    column :situation
    column :address
    column 'Pictures' do |m|
      m.thumbnails.each do |img|
        span do
          image_tag url_for(img), size: '160x160'
        end
      end
    end
    actions
  end

  filter :name
  filter :situation

  form partial: 'form'
end
