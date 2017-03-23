ActiveAdmin.register Product do
actions :all, :except => [:new]
permit_params :title, :project, :funding_goal, :active,:description, :category_id, :facebook_url, :website,:risks,:user_id,:location,:future_plans,:short_description,:raised_amount,:backers_total,:tag_list
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
