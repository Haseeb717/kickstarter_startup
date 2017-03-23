ActiveAdmin.register User do
	actions :all, :except => [:new]

	form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Edit User" do
      f.input :name
      f.input :email
      f.input :date_of_birth
      f.input :phone_number
      f.input :country
      f.input :biography
    end
    f.actions
  end

	index do
	  selectable_column
	  column :name
	  column :email
	  column :date_of_birth
	  column :phone_number
	  column :country
	  column :created_at
	  actions
	end

	show do
    attributes_table do
      row :name
      row :email
      row :phone_number
      row :date_of_birth
      row :country
      row :created_at
      row :biography
    end
  end

	filter :name
	filter :email


end
